return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  keys = {
    {
      '<leader>qx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>qX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>qs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>qc',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'Code LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>ql',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>qq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '<leader>qt',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'Todo List (Trouble)',
    },
  },
  config = function()
    require('trouble').setup()
  end,
}
