return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  event = 'BufWinEnter',
  specs = {
    'folke/snacks.nvim',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {}, {
        picker = {
          actions = require('trouble.sources.snacks').actions,
          win = {
            input = {
              keys = {
                ['<c-t>'] = {
                  'trouble_open',
                  mode = { 'n', 'i' },
                },
              },
            },
          },
        },
      })
    end,
  },
  keys = {
    {
      '<leader>W',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Trouble - Buffer Diagnostics',
    },
    {
      '<leader>wd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Trouble - All Diagnostics',
    },
    {
      '<leader>ws',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Trouble - Symbols',
    },
    {
      '<leader>wc',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'Trouble - Code LSP Definitions / references / ...',
    },
    {
      '<leader>wl',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Trouble - Location List',
    },
    {
      '<leader>wq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Trouble - Quickfix List',
    },
    {
      '<leader>w;',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'Trouble - Todo List',
    },
    {
      '<leader>w<BS>',
      function()
        require('trouble').close()
      end,
      desc = 'Trouble - Close',
    },
    {
      ']w',
      function()
        require('trouble').next { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - Next',
    },
    {
      '[w',
      function()
        require('trouble').prev { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - Previous',
    },
    {
      ']W',
      function()
        require('trouble').last { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - Last',
    },
    {
      '[W',
      function()
        require('trouble').first { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - First',
    },
  },
  config = function()
    require('trouble').setup()
  end,
}
