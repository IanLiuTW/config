return {
  'carlos-algms/agentic.nvim',
  opts = {
    -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp"
    provider = 'claude-acp', -- setting the name here is all you need to get started
    acp_providers = {
      ['claude-acp'] = {
        name = 'Claude ACP',
        command = 'claude-code-acp',
        env = {},
      },
    },
    keymaps = {
      widget = {
        close = 'q', -- String for a single keybinding
        change_mode = {
          {
            '<s-tab>', -- Same as Claude-code in insert mode
            mode = { 'i', 'n', 'v' },
          },
        },
      },
      prompt = {
        submit = {
          '<CR>', -- Normal mode, just Enter
          {
            '<C-CR>',
            mode = { 'n', 'v', 'i' },
          },
        },
        paste_image = {
          {
            '<leader>p',
            mode = { 'n' },
          },
          {
            '<C-v>', -- Same as Claude-code in insert mode
            mode = { 'i' },
          },
        },
        accept_completion = {
          {
            '<c-y>',
            mode = { 'i' },
          },
        },
      },
      diff_preview = {
        next_hunk = ']c',
        prev_hunk = '[c',
      },
    },
    diff_preview = {
      enabled = true,
      layout = 'split', -- "split" or "inline"
      center_on_navigate_hunks = true,
    },
  },
  keys = {
    {
      '<leader>:',
      function()
        require('agentic').toggle()
      end,
      mode = { 'n', 'v' },
      desc = 'Toggle Agentic Chat',
    },
    {
      '<leader>;a',
      function()
        require('agentic').add_selection_or_file_to_context()
      end,
      mode = { 'n', 'v' },
      desc = 'Agentic - Add file/selection to context',
    },
    {
      '<leader>;n',
      function()
        require('agentic').new_session()
      end,
      mode = { 'n', 'v' },
      desc = 'Agentic - New agentic session',
    },
    {
      '<leader>;r',
      function()
        require('agentic').restore_session()
      end,
      desc = 'Agentic - Restore session',
      silent = true,
      mode = { 'n', 'v' },
    },
    {
      '<leader>;s',
      function()
        require('agentic').stop_generation()
      end,
      desc = 'Agentic - Stop generation',
      silent = true,
      mode = { 'n', 'v' },
    },
  },
}
