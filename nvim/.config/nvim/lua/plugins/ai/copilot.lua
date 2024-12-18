return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  enabled = false,
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<C-CR>',
          accept_word = '<C-;>',
          accept_line = "<C-'>",
          prev = '<C-,>',
          next = '<C-.>',
          dismiss = '<C-e>',
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '<C-b>',
          jump_next = '<C-f>',
          accept = '<C-CR>',
          refresh = 'R',
          open = '<C-q>',
        },
        layout = {
          position = 'right',
          ratio = 0.4,
        },
      },
      filetypes = {
        python = true,
        yaml = true,
        toml = true,
        json = true,
        jsonc = true,
        javascript = true,
        typescript = true,
        dockerfile = true,
        markdown = true,
        lua = true,
        help = false,
        gitcommit = true,
        gitrebase = true,
        hgcommit = false,
        svn = false,
        cvs = false,
        nix = true,
        ['.'] = false,
      },
    }
  end,
  -- vim.keymap.set('i', '<C-c>', '<C-c><Cmd>lua require("copilot.suggestion").dismiss()<CR>'),
  vim.keymap.set('n', '<C-q><Up>', '<Cmd>Copilot enable<CR>'),
  vim.keymap.set('n', '<C-q><Down>', '<Cmd>Copilot disable<CR>'),
}
