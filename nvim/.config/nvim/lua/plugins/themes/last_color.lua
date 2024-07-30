return {
  'raddari/last-color.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local theme = require('last-color').recall() or 'default'
    vim.cmd.colorscheme(theme)
  end,
}
