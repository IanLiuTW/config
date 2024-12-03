return {
  'mizlan/iswap.nvim',
  event = 'BufRead',
  keys = {
    { '<leader>dk', mode = 'n', ':ISwap<cr>', desc = 'ISwap - ISwap' },
    { '<leader>dj', mode = 'n', ':ISwapWith<cr>', desc = 'ISwap - ISwapWith' },
    { '<leader>dl', mode = 'n', ':ISwapWithRight<cr>', desc = 'ISwap - ISwapWithRight' },
    { '<leader>dh', mode = 'n', ':ISwapWithLeft<cr>', desc = 'ISwap - ISwapWithLeft' },
  },
}
