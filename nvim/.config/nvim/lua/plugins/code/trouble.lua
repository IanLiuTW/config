return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  specs = {
    'folke/snacks.nvim',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {}, {
        picker = {
          actions = require('trouble.sources.snacks').actions,
          win = {
            input = { keys = { ['<a-t>'] = { 'trouble_open', mode = { 'n', 'i' } } } },
            list = { keys = { ['<a-t>'] = 'trouble_open' } },
          },
        },
      })
    end,
  },
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Diagnostics - Buffer (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics - All buffers (Trouble)',
    },
    {
      '<leader>xs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'List - Symbols',
    },
    {
      '<leader>xc',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'List - LSP definitions and references',
    },
    {
      '<leader>xl',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'List - Location list',
    },
    {
      '<leader>xq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'List - Quickfix list',
    },
    {
      '<leader>xt',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'List - Todo comments',
    },
    {
      '<leader>x<BS>',
      function()
        require('trouble').close()
      end,
      desc = 'List - Close Trouble',
    },
    {
      ']w',
      function()
        require('trouble').next { skip_groups = true, jump = true }
      end,
      desc = 'List - Next item',
    },
    {
      '[w',
      function()
        require('trouble').prev { skip_groups = true, jump = true }
      end,
      desc = 'List - Previous item',
    },
    {
      ']W',
      function()
        require('trouble').last { skip_groups = true, jump = true }
      end,
      desc = 'List - Last item',
    },
    {
      '[W',
      function()
        require('trouble').first { skip_groups = true, jump = true }
      end,
      desc = 'List - First item',
    },
  },
  config = function()
    require('trouble').setup()
  end,
}
