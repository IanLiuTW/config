return {
  'carlos-algms/agentic.nvim',
  opts = {
    -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp"
    provider = 'gemini-acp', -- setting the name here is all you need to get started
    keymaps = {
      widget = {
        close = 'q', -- String for a single keybinding
        change_mode = {
          {
            '<leader>;m',
            mode = { 'i', 'n', 'v' },
          },
        },
      },
      prompt = {
        submit = {
          '<CR>', -- Normal mode, just Enter
          {
            '<S-CR>',
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
      desc = 'Add file or selection to Agentic to Context',
    },
    {
      '<leader>;n',
      function()
        require('agentic').new_session()
      end,
      mode = { 'n', 'v' },
      desc = 'New Agentic Session',
    },
  },
}