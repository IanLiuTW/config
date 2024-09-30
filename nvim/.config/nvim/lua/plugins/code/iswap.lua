return {
  'mizlan/iswap.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>cnb', mode = 'n', ':ISwap<cr>', desc = 'Flash' },
    { '<leader>cns', mode = 'n', ':ISwapWith<cr>', desc = 'Flash' },
    { '<leader>cnl', mode = 'n', ':ISwapWithRight<cr>', desc = 'Flash' },
    { '<leader>cnh', mode = 'n', ':ISwapWithLeft<cr>', desc = 'Flash' },
  },
}
