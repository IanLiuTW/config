return {
  'zbirenbaum/copilot.lua',
  dependencies = {
    'copilotlsp-nvim/copilot-lsp',
    init = function()
      vim.g.copilot_nes_debounce = 200
    end,
    opts = {
      nes = {
        move_count_threshold = 2,
      },
    },
  },
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
          accept = '<C-CR>',
          accept_word = '<C-h>',
          accept_line = '<C-l>',
          prev = '<C-k>',
          next = '<C-j>',
          dismiss = '<C-q>',
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          open = '<C-S-Cr>',
          accept = '<C-y>',
          jump_prev = '<C-p>',
          jump_next = '<C-n>',
          refresh = 'R',
        },
        layout = {
          position = 'right',
          ratio = 0.4,
        },
      },
      nes = {
        enabled = true,
        keymap = {
          accept_and_goto = '<S-CR>',
          accept = false,
          dismiss = '<Esc>',
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
        gitcommit = true,
        gitrebase = true,
        hgcommit = false,
        nix = true,
        svn = false,
        cvs = false,
        help = false,
        ['.'] = false,
      },
    }
  end,
  vim.keymap.set('n', "<leader>'<Up>", '<Cmd>Copilot enable<CR>'),
  vim.keymap.set('n', "<leader>'<Down>", '<Cmd>Copilot disable<CR>'),
}
