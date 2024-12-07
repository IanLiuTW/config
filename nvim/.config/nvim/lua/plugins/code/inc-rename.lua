return {
  'smjonas/inc-rename.nvim',
  event = 'BufRead',
  keys = {
    {
      '<leader>dr',
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
