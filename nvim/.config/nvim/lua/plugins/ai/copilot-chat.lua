local prompts = {
  -- Code related prompts
  Explain = 'Please explain how the following code works.',
  Review = 'Please review the following code and provide suggestions for improvement.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
  SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.',
  SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.',
  -- Text related prompts
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
}

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      'zbirenbaum/copilot.lua', -- zbirenbaum/copilot.lua or github/copilot.vim
      'nvim-lua/plenary.nvim', -- for curl, log wrapper
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
    },
    opts = {
      -- auto_follow_cursor = false, -- Don't follow the cursor after getting response
      -- show_help = true, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat

      model = 'gpt-4o', -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
      prompts = prompts,
      temperature = 0.1, -- GPT temperature

      question_header = '👤 User ', -- Header to use for user questions
      answer_header = '🤖 Copilot ', -- Header to use for AI answers
      error_header = '🛑 Error ', -- Header to use for errors
      separator = '󰇘󰇘󰇘', -- Separator to use in chat

      show_folds = true, -- Shows folds for sections in chat
      show_help = true, -- Shows help message as virtual lines when waiting for user input
      auto_follow_cursor = false, -- Auto-follow cursor in chat
      auto_insert_mode = true, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
      clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
      highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

      context = 'buffer', -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
      history_path = vim.fn.stdpath 'data' .. '/copilotchat_history', -- Default path to stored history
      callback = nil, -- Callback to use when ask response is received

      mappings = {
        complete = {
          detail = 'Use @<Tab> or /<Tab> for options.',
          insert = '<A-Cr>',
        },
        close = {
          normal = 'q',
          insert = '<C-e>',
        },
        -- Reset the chat buffer
        reset = {
          normal = 'R',
          insert = '<C-r>',
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-CR>',
        },
        -- Accept the diff
        accept_diff = {
          normal = '<A-Cr>',
          insert = '<A-Cr>',
        },
        -- Yank the diff in the response to register
        yank_diff = {
          normal = 'gmy',
        },
        -- Show the diff
        show_diff = {
          normal = 'gmd',
        },
        -- Show the prompt
        show_system_prompt = {
          normal = 'gmp',
        },
        -- Show the user selection
        show_user_selection = {
          normal = 'gms',
        },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      local select = require 'CopilotChat.select'
      -- Use unnamed register for the selection
      opts.selection = select.unnamed

      -- Override the git prompts message
      opts.prompts.Commit = {
        prompt = 'Write commit message for the change with commitizen convention',
        selection = select.gitdiff,
      }
      opts.prompts.CommitStaged = {
        prompt = 'Write commit message for the change with commitizen convention',
        selection = function(source)
          return select.gitdiff(source, true)
        end,
      }

      chat.setup(opts)

      require('CopilotChat.integrations.cmp').setup()

      vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = '*', range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command('CopilotChatInline', function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = 'float',
            relative = 'cursor',
            width = 1,
            height = 0.5,
            row = 1,
          },
        })
      end, { nargs = '*', range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = '*', range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == 'copilot-chat' then
            vim.bo.filetype = 'markdown'
          end
        end,
      })

      -- Add which-key mappings
      local wk = require 'which-key'
      wk.add {
        { '<leader>i', group = 'A[I]', mode = { 'n', 'x' } }, -- group
        { '<leader>im', group = 'CopilotChat - Git' }, -- group
        { '<leader>imd', desc = 'Show diff' },
        { '<leader>imp', desc = 'System prompt' },
        { '<leader>ims', desc = 'Show selection' },
        { '<leader>imy', desc = 'Yank diff' },
      }
    end,
    event = 'VeryLazy',
    keys = {
      -- Toggle Copilot Chat Vsplit
      { '<leader>I', '<cmd>CopilotChatToggle<cr>', desc = 'A[I] - Toggle CopilotChat' },
      {
        '<leader>ii',
        ':CopilotChatInline<cr>',
        mode = 'n',
        desc = 'CopilotChat - Inline chat',
      },
      -- Custom input for CopilotChat
      {
        '<leader>iq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            vim.cmd('CopilotChat ' .. input)
          end
        end,
        desc = 'CopilotChat - Quick Chat',
      },
      -- Quick chat with Copilot
      {
        '<leader>iQ',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            vim.cmd('CopilotChatBuffer ' .. input)
          end
        end,
        desc = 'CopilotChat - Quick Chat (Buffer)',
      },
      -- Show help actions with telescope
      {
        '<leader>ih',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = 'CopilotChat - Help actions',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ip',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>iP',
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = 'x',
        desc = 'CopilotChat - Prompt actions',
      },
      -- Code related commands
      { '<leader>ie', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>it', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>ir', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
      { '<leader>iR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
      { '<leader>in', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
      -- Chat with Copilot in visual mode
      {
        '<leader>iv',
        ':CopilotChatVisual',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>im',
        '<cmd>CopilotChatCommit<cr>',
        desc = 'CopilotChat - Generate commit message for all changes',
      },
      {
        '<leader>iM',
        '<cmd>CopilotChatCommitStaged<cr>',
        desc = 'CopilotChat - Generate commit message for staged changes',
      },
      -- Debug
      { '<leader>id', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
      -- Fix the issue with diagnostic
      { '<leader>if', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
      -- Clear buffer and chat history
      { '<leader>ix', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      -- Copilot Chat Models
      { '<leader>i?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
    },
  },
}
