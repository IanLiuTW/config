return {
  'anuvyklack/windows.nvim',
  dependencies = {
    'anuvyklack/middleclass',
    'anuvyklack/animation.nvim',
  },
  keys = {
    { '<A-\\>', '<Cmd>WindowsMaximize<CR>' , desc = 'Toggle Maximize Window'},
    { '<A-->', '<Cmd>WindowsMaximizeVertically<CR>', desc = 'Toggle Maximize Window Vertically' },
    { '<A-=>', '<Cmd>WindowsMaximizeHorizontally<CR>', desc = 'Toggle Maximize Window Horiziontally' },
    { '<A-0>', '<Cmd>WindowsEqualize<CR>', desc = 'Equalize Windows Size' },
  },
  config = function()
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false
    require('windows').setup()
  end,
}
