return {
  'mizlan/iswap.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>dj', mode = 'n', ':ISwap<cr>', desc = 'ISwap - ISwap' },
    { '<leader>dk', mode = 'n', ':ISwapWith<cr>', desc = 'ISwap - ISwapWith' },
    { '<leader>dl', mode = 'n', ':ISwapWithRight<cr>', desc = 'ISwap - ISwapWithRight' },
    { '<leader>dh', mode = 'n', ':ISwapWithLeft<cr>', desc = 'ISwap - ISwapWithLeft' },
  },
}
