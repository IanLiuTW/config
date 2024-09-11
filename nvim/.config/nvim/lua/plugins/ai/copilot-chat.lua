return {
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
    temperature = 0.1, -- GPT temperature

    question_header = '👤 User ', -- Header to use for user questions
    answer_header = '🤖 Copilot ', -- Header to use for AI answers
    error_header = '🛑 Error ', -- Header to use for errors
    separator = '󰇘󰇘󰇘', -- Separator to use in chat

    show_folds = true, -- Shows folds for sections in chat
    show_help = true, -- Shows help message as virtual lines when waiting for user input
    auto_follow_cursor = false, -- Auto-follow cursor in chat
    auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
    clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
    highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

    context = 'none', -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
    history_path = vim.fn.stdpath 'data' .. '/copilotchat_history', -- Default path to stored history
    callback = nil, -- Callback to use when ask response is received

    mappings = {
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
        normal = 'gy',
        register = '*',
      },
      -- Show the diff
      show_diff = {
        normal = 'gd',
      },
      -- Show the prompt
      show_system_prompt = {
        normal = 'gp',
      },
      -- Show the user selection
      show_user_selection = {
        normal = 'gs',
      },
    },
  },
  config = function(_, opts)
    local chat = require 'CopilotChat'
    local select = require 'CopilotChat.select'

    opts.prompts = {
      Explain = {
        prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
      },
      Review = {
        prompt = '/COPILOT_REVIEW Review the selected code.',
        callback = function(response, source)
          local ns = vim.api.nvim_create_namespace 'copilot_review'
          local diagnostics = {}
          for line in response:gmatch '[^\r\n]+' do
            if line:find '^line=' then
              local start_line = nil
              local end_line = nil
              local message = nil
              local single_match, message_match = line:match '^line=(%d+): (.*)$'
              if not single_match then
                local start_match, end_match, m_message_match = line:match '^line=(%d+)-(%d+): (.*)$'
                if start_match and end_match then
                  start_line = tonumber(start_match)
                  end_line = tonumber(end_match)
                  message = m_message_match
                end
              else
                start_line = tonumber(single_match)
                end_line = start_line
                message = message_match
              end

              if start_line and end_line then
                table.insert(diagnostics, {
                  lnum = start_line - 1,
                  end_lnum = end_line - 1,
                  col = 0,
                  message = message,
                  severity = vim.diagnostic.severity.WARN,
                  source = 'Copilot Review',
                })
              end
            end
          end
          vim.diagnostic.set(ns, source.bufnr, diagnostics)
        end,
      },
      Fix = {
        prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
      },
      Optimize = {
        prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readability.',
      },
      Docs = {
        prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
      },
      Tests = {
        prompt = '/COPILOT_GENERATE Please generate tests for my code.',
      },
      FixDiagnostic = {
        prompt = 'Please assist with the following diagnostic issue in file:',
        selection = select.diagnostics,
      },
      Commit = {
        prompt = '/COPILOT_GENERATE Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
        selection = select.gitdiff,
      },
      CommitStaged = {
        prompt = '/COPILOT_GENERATE Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
        selection = function(source)
          return select.gitdiff(source, true)
        end,
      },
      -- Code related custom prompts
      Refactor = {
        prompt = '/COPILOT_GENERATE Please refactor the following code to improve its clarity and readability.',
      },
      BetterNamings = {
        prompt = '/COPILOT_GENERATE Please provide better names for the following variables and functions.',
      },
      SwaggerApiDocs = {
        prompt = '/COPILOT_GENERATE Please provide documentation for the following API using Swagger.',
      },
      -- Text related custom prompts
      Summarize = {
        prompt = '/COPILOT_REVIEW Please summarize the following text.',
      },
      Spelling = {
        prompt = '/COPILOT_GENERATE Please correct any grammar and spelling errors in the following text.',
      },
      Wording = {
        prompt = '/COPILOT_GENERATE Please improve the grammar and wording of the following text.',
      },
      Concise = {
        prompt = '/COPILOT_GENERATE Please rewrite the following text to make it more concise.',
      },
    }

    chat.setup(opts)

    vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
      chat.ask(args.args, { selection = select.buffer })
    end, { nargs = '*', range = true })

    vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = '*', range = true })

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
      { '<A-a>', group = 'A[I]', mode = { 'n', 'x' } },
    }
  end,
  keys = {
    { '<A-a><Space>', ':CopilotChatBuffer<cr>', mode = 'n', desc = 'CopilotChat - Toggle CopilotChat (Buffer)' },
    { '<A-a><Space>', ':CopilotChatVisual<cr>', mode = 'x', desc = 'CopilotChat - Toggle CopilotChat (Visual)' },
    { '<A-a>i', ':CopilotChatInline<cr>', mode = 'n', desc = 'CopilotChat - Inline chat' },

    {
      '<A-a>q',
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
      '<A-a>Q',
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
      '<A-a>h',
      function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.help_actions())
      end,
      desc = 'CopilotChat - Help actions',
    },
    -- Show prompts actions with telescope
    {
      '<A-a>a',
      function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
      end,
      desc = 'CopilotChat - Prompt actions',
    },
    {
      '<A-a>a',
      function()
        require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions { selection = require('CopilotChat.select').visual })
      end,
      mode = 'x',
      desc = 'CopilotChat - Prompt actions',
    },
    -- Code related commands
    { '<A-a>e', '<cmd>CopilotChatExplain<cr>', mode = 'x', desc = 'CopilotChat - Explain code' },
    { '<A-a>r', '<cmd>CopilotChatReview<cr>', mode = 'x', desc = 'CopilotChat - Review code' },
    { '<A-a>f', '<cmd>CopilotChatFix<cr>', mode = 'x', desc = 'CopilotChat - Fix code' },
    { '<A-a>o', '<cmd>CopilotChatOptimize<cr>', mode = 'x', desc = 'CopilotChat - Optimize code' },
    { '<A-a>d', '<cmd>CopilotChatDocs<cr>', mode = 'x', desc = 'CopilotChat - Generate documentation' },
    { '<A-a>t', '<cmd>CopilotChatTests<cr>', mode = 'x', desc = 'CopilotChat - Generate tests' },
    { '<A-a>R', '<cmd>CopilotChatRefactor<cr>', mode = 'x', desc = 'CopilotChat - Refactor code' },

    { '<A-a>f', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
    { '<A-a>g', '<cmd>CopilotChatCommitStaged<cr>', desc = 'CopilotChat - Generate commit message for staged changes' },
    { '<A-a>G', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat - Generate commit message for all changes' },

    { '<A-a><bs>', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
    { '<A-a>/', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
    { '<A-a>?', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
  },
}
