return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  event = 'BufWinEnter',
  keys = {
    {
      '<leader>E',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Trouble - Buffer Diagnostics',
    },
    {
      '<leader>ed',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Trouble - All Diagnostics',
    },
    {
      '<leader>es',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Trouble - Symbols',
    },
    {
      '<leader>ec',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'Trouble - Code LSP Definitions / references / ...',
    },
    {
      '<leader>el',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Trouble - Location List',
    },
    {
      '<leader>eq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Trouble - Quickfix List',
    },
    {
      '<leader>e;',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'Trouble - Todo List',
    },
    {
      '<leader>e<BS>',
      function()
        require('trouble').close()
      end,
      desc = 'Trouble - Close',
    },
    {
      ']e',
      function()
        require('trouble').next { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - Next',
    },
    {
      '[e',
      function()
        require('trouble').prev { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - Previous',
    },
    {
      ']E',
      function()
        require('trouble').last { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - Last',
    },
    {
      '[E',
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
