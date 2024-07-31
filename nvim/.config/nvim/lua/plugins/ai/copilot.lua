return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<M-Cr>',
          accept_word = '<M-l>',
          accept_line = '<M-j>',
          prev = '<M-[>',
          next = '<M-]>',
          dismiss = '<Esc>',
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '<M-[>',
          jump_next = '<M-]>',
          accept = '<CR>',
          refresh = 'r',
          open = '<M-\\>',
        },
        layout = {
          position = 'right',
          ratio = 0.4,
        },
      },
      filetypes = {
        yaml = false,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
    }
  end,
  vim.keymap.set('i', '<C-c>', '<C-c><Cmd>lua require("copilot.suggestion").dismiss()<CR>'),
}
