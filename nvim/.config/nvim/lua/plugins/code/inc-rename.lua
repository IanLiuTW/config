return {
  'smjonas/inc-rename.nvim',
  keys = {
    {
      '<leader>cn',
      function()
        return ':IncRename ' .. vim.fn.expand '<cword>'
      end,
      desc = 'Code - Rename symbol',
      expr = true,
    },
  },
  config = function()
    require('inc_rename').setup()
  end,
}
