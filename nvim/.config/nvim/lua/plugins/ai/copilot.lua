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
          accept = '<A-CR>',
          accept_word = '<A-l>',
          accept_line = '<A-j>',
          prev = '<A-[>',
          next = '<A-]>',
          dismiss = '<Esc>',
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '<A-[>',
          jump_next = '<A-]>',
          accept = '<A-CR>',
          refresh = 'R',
          open = '<A-\\>',
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
  vim.keymap.set('n', '<A-a>\\', '<Cmd>Copilot enable<CR>'),
  vim.keymap.set('n', '<A-a>|', '<Cmd>Copilot disable<CR>'),
}
