return {
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
    config = function()
      require('trouble').setup()

      require('which-key').add {
        { '<leader>x', group = '[X] for Trouble' },
      }

      local actions = require 'telescope.actions'
      local open_with_trouble = require('trouble.sources.telescope').open
      -- Use this to add more results without clearing the trouble list
      local add_to_trouble = require('trouble.sources.telescope').add
      local telescope = require 'telescope'
      telescope.setup {
        defaults = {
          mappings = {
            -- i = { ['<c-t>'] = open_with_trouble },
            -- n = { ['<c-t>'] = open_with_trouble },
          },
        },
      }
    end,
  },
}
