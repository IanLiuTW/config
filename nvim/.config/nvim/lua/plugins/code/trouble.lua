return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  keys = {
    {
      '<leader>E',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Trouble - Buffer Diagnostics',
    },
    {
      '<leader>ee',
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
      '<leader>et',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'Trouble - Todo List',
    },
  },
  config = function()
    require('trouble').setup()
  end,
}
