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
                ['<c-w>'] = {
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
      '<leader>H',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Trouble - Buffer Diagnostics',
    },
    {
      '<leader>hd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Trouble - All Diagnostics',
    },
    {
      '<leader>hs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Trouble - Symbols',
    },
    {
      '<leader>hc',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'Trouble - Code LSP Definitions / references / ...',
    },
    {
      '<leader>hl',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Trouble - Location List',
    },
    {
      '<leader>hq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Trouble - Quickfix List',
    },
    {
      '<leader>h;',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'Trouble - Todo List',
    },
    {
      '<leader>h<BS>',
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
