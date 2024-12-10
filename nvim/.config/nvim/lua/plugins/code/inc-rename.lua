return {
  'smjonas/inc-rename.nvim',
  event = 'BufRead',
  keys = {
    {
      '<leader>dR',
      function()
        return ':IncRename ' .. vim.fn.expand '<cword>'
      end,
      desc = 'LSP - Rename Variable',
      expr = true,
    },
  },
  config = function()
    require('inc_rename').setup()
  end,
}
