return {
  'CopilotC-Nvim/CopilotChat.nvim',
  event = 'BufEnter',
  branch = 'main',
  build = 'make tiktoken',
  dependencies = {
    'zbirenbaum/copilot.lua', -- zbirenbaum/copilot.lua or github/copilot.vim
    { 'nvim-lua/plenary.nvim', branch = 'master' },
    'nvim-telescope/telescope.nvim',
  },
  opts = {
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
    insert_at_end = false,
    clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
    highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

    context = 'none', -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
    history_path = vim.fn.stdpath 'data' .. '/copilotchat_history', -- Default path to stored history
    callback = nil, -- Callback to use when ask response is received

    mappings = {
      complete = {
        insert = '<Tab>',
      },
      close = {
        normal = 'q',
        insert = '<C-c>',
      },
      reset = {
        normal = 'R',
        insert = '<C-r>',
      },
      submit_prompt = {
        normal = '<CR>',
        insert = '<C-CR>',
      },
      accept_diff = {
        normal = '<C-y>',
        insert = '<C-y>',
      },
      toggle_sticky = {
        detail = 'Makes line under cursor sticky or deletes sticky line.',
        normal = 'gr',
      },
      jump_to_diff = {
        normal = 'gj',
      },
      quickfix_diffs = {
        normal = 'gq',
      },
      yank_diff = {
        normal = 'gy',
        register = '"',
      },
      show_diff = {
        normal = 'gd',
      },
      show_info = {
        normal = 'gi',
      },
      show_context = {
        normal = 'gc',
      },
      show_help = {
        normal = 'gh',
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
        prompt = '/COPILOT_GENERATE Please assist with the following diagnostic issues in file:',
        selection = select.diagnostics,
      },
      ExplainDiagnostic = {
        prompt = '/COPILOT_EXPLAIN explain the diagnostic issues in file:',
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
        prompt = '/COPILOT_GENERATE Please summarize the following text.',
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

    vim.api.nvim_create_user_command('CopilotChatInlineVisual', function(args)
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

    vim.api.nvim_create_user_command('CopilotChatInlineBuffer', function(args)
      chat.ask(args.args, {
        selection = select.buffer,
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.5,
          row = 1,
        },
      })
    end, { nargs = '*', range = true })

    vim.api.nvim_create_user_command('CopilotChatReviewClear', function()
      local ns = vim.api.nvim_create_namespace 'copilot_review'
      vim.diagnostic.reset(ns)
    end, {})

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
      { '<C-q>', group = 'A[I]', mode = { 'n', 'x' } },
    }
  end,
  keys = {
    { '<C-q><cr>', ':CopilotChatBuffer<cr>', mode = 'n', desc = 'CopilotChat - Open Chat (Buffer)' },
    { '<C-q><cr>', ':CopilotChatVisual<cr>', mode = 'x', desc = 'CopilotChat - Open Chat (Visual)' },
    { '<C-q><Space>', ':CopilotChatInlineBuffer<cr>', mode = 'n', desc = 'CopilotChat - Open Inline Chat (Buffer)' },
    { '<C-q><Space>', ':CopilotChatInlineVisual<cr>', mode = 'x', desc = 'CopilotChat - Open Inline Chat (Visual)' },
    {
      '<C-q><TAB>',
      function()
        local input = vim.fn.input 'Quick Chat (Visual): '
        if input ~= '' then
          vim.cmd('CopilotChatVisual ' .. input)
        end
      end,
      mode = { 'x' },
      desc = 'CopilotChat - Quick Chat (Visual)',
    },
    {
      '<C-q><TAB>',
      function()
        local input = vim.fn.input 'Quick Chat (Buffer): '
        if input ~= '' then
          vim.cmd('CopilotChatBuffer ' .. input)
        end
      end,
      mode = { 'n' },
      desc = 'CopilotChat - Quick Chat (Buffer)',
    },
    {
      '<C-q><S-TAB>',
      function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          vim.cmd('CopilotChat ' .. input)
        end
      end,
      mode = { 'n' },
      desc = 'CopilotChat - Quick Chat (None)',
    },
    {
      '<C-q>a',
      function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
      end,
      desc = 'CopilotChat - Prompt actions',
    },
    {
      '<C-q>a',
      function()
        require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions { selection = require('CopilotChat.select').visual })
      end,
      mode = 'x',
      desc = 'CopilotChat - Prompt actions',
    },
    -- Code related commands
    { '<C-q>e', '<cmd>CopilotChatExplain<cr>', mode = 'x', desc = 'CopilotChat - Explain code' },
    { '<C-q>v', '<cmd>CopilotChatReview<cr>', mode = 'x', desc = 'CopilotChat - Review code' },
    { '<C-q>f', '<cmd>CopilotChatFix<cr>', mode = 'x', desc = 'CopilotChat - Fix code' },
    { '<C-q>o', '<cmd>CopilotChatOptimize<cr>', mode = 'x', desc = 'CopilotChat - Optimize code' },
    { '<C-q>\'', '<cmd>CopilotChatDocs<cr>', mode = 'x', desc = 'CopilotChat - Generate documentation' },
    { '<C-q>t', '<cmd>CopilotChatTests<cr>', mode = 'x', desc = 'CopilotChat - Generate tests' },
    { '<C-q>r', '<cmd>CopilotChatRefactor<cr>', mode = 'x', desc = 'CopilotChat - Refactor code' },
    { '<C-q>b', '<cmd>CopilotChatBetterNamings<cr>', mode = 'x', desc = 'CopilotChat - Generate Better Namings' },

    { '<C-q>d', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
    { '<C-q>D', '<cmd>CopilotChatExplainDiagnostic<cr>', desc = 'CopilotChat - Explain Diagnostic' },
    { '<C-q>g', '<cmd>CopilotChatCommitStaged<cr>', desc = 'CopilotChat - Generate commit message for staged changes' },
    { '<C-q>G', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat - Generate commit message for all changes' },

    { '<C-q>q', '<cmd>CopilotChatClose<cr>', desc = 'CopilotChat - Close' },
    { '<C-q>V', '<cmd>CopilotChatReviewClear<cr>', desc = 'CopilotChat - Review code clear highlight' },
    { '<C-q><bs>', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
    { '<C-q>/', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
    { '<C-q>?', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
  },
}
