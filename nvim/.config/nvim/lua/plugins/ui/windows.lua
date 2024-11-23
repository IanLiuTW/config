return {
  'anuvyklack/windows.nvim',
  dependencies = {
    'anuvyklack/middleclass',
    'anuvyklack/animation.nvim',
  },
  keys = {
    { '<C-W><Space>', '<Cmd>WindowsMaximize<CR>',             desc = 'Toggle Maximize Window'},
    { '<C-W>_',       '<Cmd>WindowsMaximizeVertically<CR>',   desc = 'Toggle Maximize Window Vertically' },
    { '<C-W>|',       '<Cmd>WindowsMaximizeHorizontally<CR>', desc = 'Toggle Maximize Window Horiziontally' },
    { '<C-W>=',       '<Cmd>WindowsEqualize<CR>',             desc = 'Equalize Windows Size' },
  },
  config = function()
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false
    require('windows').setup()
  end,
}
