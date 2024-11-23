return {
  'smjonas/inc-rename.nvim',
  envent = 'BufRead',
  keys = {
    {
      '<leader>dR',
      function()
        return ':IncRename ' .. vim.fn.expand '<cword>'
      end,
      desc = 'LSP: [R]ename',
      expr = true,
    },
  },
  config = function()
    require('inc_rename').setup()
  end,
}
