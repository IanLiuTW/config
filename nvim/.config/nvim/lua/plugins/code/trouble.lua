return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  keys = {
    {
      '<leader>~',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Trouble - Buffer Diagnostics',
    },
    {
      '<leader>`d',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Trouble - All Diagnostics',
    },
    {
      '<leader>`s',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Trouble - Symbols',
    },
    {
      '<leader>`c',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'Trouble - Code LSP Definitions / references / ...',
    },
    {
      '<leader>`l',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Trouble - Location List',
    },
    {
      '<leader>`q',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Trouble - Quickfix List',
    },
    {
      '<leader>`;',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'Trouble - Todo List',
    },
    {
      '<leader>`<BS>',
      function()
        require('trouble').close()
      end,
      desc = 'Trouble - Close',
    },
    {
      ']`',
      function()
        require('trouble').next { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - Next',
    },
    {
      '[`',
      function()
        require('trouble').prev { skip_groups = true, jump = true }
      end,
      desc = 'Trouble - Previous',
    },
  },
  config = function()
    require('trouble').setup()
  end,
}
