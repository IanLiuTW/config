return {
  'CopilotC-Nvim/CopilotChat.nvim',
  event = 'BufEnter',
  branch = 'main',
  build = 'make tiktoken',
  dependencies = {
    'zbirenbaum/copilot.lua', -- zbirenbaum/copilot.lua or github/copilot.vim
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  opts = {
    system_prompt = 'COPILOT_INSTRUCTIONS', -- System prompt to use (can be specified manually in prompt via /).

    model = 'gpt-4.1', -- Default model to use, see ':CopilotChatModels' for available models (can be specified manually in prompt via $).
    agent = 'copilot', -- Default agent to use, see ':CopilotChatAgents' for available agents (can be specified manually in prompt via @).
    context = nil, -- Default context or array of contexts to use (can be specified manually in prompt via #).
    sticky = nil, -- Default sticky prompt or array of sticky prompts to use at start of every new chat.

    temperature = 0.1, -- GPT result temperature
    headless = false, -- Do not write to chat buffer and use history (useful for using custom processing)
    stream = nil, -- Function called when receiving stream updates (returned string is appended to the chat buffer)
    callback = nil, -- Function called when full response is received (returned string is stored to history)
    remember_as_sticky = true, -- Remember model/agent/context as sticky prompts when asking questions

    -- see select.lua for implementation
    selection = function(source)
      local select = require 'CopilotChat.select'
      return select.visual(source) or select.buffer(source)
    end,

    show_help = true, -- Shows help message as virtual lines when waiting for user input
    highlight_selection = true, -- Highlight selection
    highlight_headers = true, -- Highlight headers in chat, disable if using markdown renderers (like render-markdown.nvim)
    references_display = 'virtual', -- 'virtual', 'write', Display references in chat as virtual text or write to buffer
    auto_follow_cursor = false, -- Auto-follow cursor in chat
    auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
    insert_at_end = false,
    clear_chat_on_new_prompt = false, -- Clears chat on every new prompt

    chat_autocomplete = true, -- Enable chat autocompletion (when disabled, requires manual `mappings.complete` trigger)

    log_path = vim.fn.stdpath 'state' .. '/CopilotChat.log', -- Default path to log file
    history_path = vim.fn.stdpath 'data' .. '/copilotchat_history', -- Default path to stored history

    question_header = '👤 User ', -- Header to use for user questions
    answer_header = '🤖 Copilot ', -- Header to use for AI answers
    error_header = '🛑 Error ', -- Header to use for errors
    separator = '󰇘󰇘󰇘', -- Separator to use in chat

    providers = {
      copilot = {},
      github_models = {},
      copilot_embeddings = {},
    },

    -- see config/contexts.lua for implementation
    contexts = {
      buffer = {},
      buffers = {},
      file = {},
      files = {},
      git = {},
      url = {},
      register = {},
      quickfix = {},
      system = {},
    },

    -- see config/prompts.lua for implementation
    prompts = {
      Explain = {
        prompt = 'Write an explanation for the selected code as paragraphs of text.',
        system_prompt = 'COPILOT_EXPLAIN',
      },
      Review = {
        prompt = 'Review the selected code.',
        system_prompt = 'COPILOT_REVIEW',
      },
      Fix = {
        prompt = 'There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.',
      },
      Optimize = {
        prompt = 'Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.',
        context = { 'buffer', 'git:staged' },
      },
      Docs = {
        prompt = 'Please add documentation comments to the selected code.',
      },
      Tests = {
        prompt = 'Please generate tests for my code.',
      },
      Commit = {
        prompt = 'Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
        context = 'git:staged',
      },
      -- Code related prompts
      FixDiagnostic = {
        prompt = 'Fix the diagnostic issues',
        system_prompt = 'COPILOT_REVIEW',
        context = 'buffer',
      },
      ExplainDiagnostic = {
        prompt = 'Explain the diagnostic issues',
        system_prompt = 'COPILOT_EXPLAIN',
        context = 'buffer',
      },
      Refactor = {
        prompt = 'Please refactor the following code to improve its clarity and readability.',
      },
      BetterNamings = {
        prompt = 'Please provide better names for the following variables and functions.',
      },
      -- Text related prompts
      Summarize = {
        prompt = 'Please summarize the following text.',
      },
      Spelling = {
        prompt = 'Please correct any grammar and spelling errors in the following text.',
      },
      Wording = {
        prompt = 'Please improve the grammar and wording of the following text.',
      },
      Concise = {
        prompt = 'Please rewrite the following text to make it more concise.',
      },
    },

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
      toggle_sticky = {
        normal = 'grr',
      },
      clear_stickies = {
        normal = 'grx',
      },
      accept_diff = {
        normal = '<C-y>',
        insert = '<C-y>',
      },
      jump_to_diff = {
        normal = 'gj',
      },
      quickfix_answers = {
        normal = 'gqa',
      },
      quickfix_diffs = {
        normal = 'gqd',
      },
      yank_diff = {
        normal = 'gy',
        register = '"', -- Default register to use for yanking
      },
      show_diff = {
        normal = 'gd',
        full_diff = false, -- Show full diff instead of unified diff when showing diff window
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

    chat.setup(opts)

    vim.api.nvim_create_user_command('CopilotChatBuffer', function()
      chat.open { context = 'buffer' }
    end, { nargs = '*', range = true })

    vim.api.nvim_create_user_command('CopilotChatBuffers', function()
      chat.open { context = 'buffers' }
    end, { nargs = '*', range = true })

    vim.api.nvim_create_user_command('CopilotChatFiles', function()
      chat.open { context = 'files' }
    end, { nargs = '*', range = true })

    vim.api.nvim_create_user_command('CopilotChatInline', function()
      chat.open {
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.5,
          row = 1,
        },
      }
    end, { nargs = '*', range = true })

    vim.api.nvim_create_user_command('CopilotChatInlineBuffer', function()
      chat.open {
        context = 'buffer',
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.5,
          row = 1,
        },
      }
    end, { nargs = '*', range = true })

    -- Custom buffer for CopilotChat
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-*',
      callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.number = true
        vim.opt_local.conceallevel = 0
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
    -- { '<C-q><C-q>', ':CopilotChatToggle<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Toggle' },
    { '<C-q>q', ':CopilotChatClose<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Close' },
    { '<C-q><bs>', '<cmd>CopilotChatReset<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Reset' },
    { '<C-q>.', '<cmd>CopilotChatStop<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Stop' },

    { '<C-q><Tab>', ':CopilotChat<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Start' },
    { '<C-q>1', ':CopilotChatInline<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Open Inline Chat' },
    { '<C-q>2', ':CopilotChatBuffer<cr>', mode = 'n', desc = 'CopilotChat - Open Chat (Buffer)' },
    { '<C-q>3', ':CopilotChatBuffers<cr>', mode = 'n', desc = 'CopilotChat - Open Chat (Buffers)' },
    { '<C-q>4', ':CopilotChatFiles<cr>', mode = 'n', desc = 'CopilotChat - Open Chat (Files)' },
    -- { '<C-q><S-Tab>', ':CopilotChatInlineBuffer<cr>', mode = 'n', desc = 'CopilotChat - Open Inline Chat (Buffer)' },

    { '<C-q><Space>', '<cmd>CopilotChatPrompts<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Select Prompt' },
    { '<C-q>/', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Model' },
    { '<C-q>?', '<cmd>CopilotChatAgents<cr>', desc = 'CopilotChat - Select Agent' },

    { '<C-q>e', '<cmd>CopilotChatExplain<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Explain code' },
    { '<C-q>v', '<cmd>CopilotChatReview<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Review code' },
    { '<C-q>f', '<cmd>CopilotChatFix<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Fix code' },
    { '<C-q>o', '<cmd>CopilotChatOptimize<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Optimize code' },
    { "<C-q>'", '<cmd>CopilotChatDocs<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Generate documentation' },
    { '<C-q>t', '<cmd>CopilotChatTests<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Generate tests' },
    { '<C-q>g', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat - Generate commit message for all changes' },
    { '<C-q>r', '<cmd>CopilotChatRefactor<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Refactor code' },
    { '<C-q>b', '<cmd>CopilotChatBetterNamings<cr>', mode = { 'n', 'x' }, desc = 'CopilotChat - Generate Better Namings' },

    { '<C-q>d', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
    { '<C-q>s', '<cmd>CopilotChatExplainDiagnostic<cr>', desc = 'CopilotChat - Explain Diagnostic' },
  },
}
