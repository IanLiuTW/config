return {
  'mizlan/iswap.nvim',
  event = 'BufRead',
  keys = {
    { '<leader>dk', mode = 'n', '<cmd>ISwap<cr>', desc = 'ISwap - ISwap' },
    { '<leader>dj', mode = 'n', '<cmd>ISwapWith<cr>', desc = 'ISwap - ISwapWith' },
    { '<leader>dl', mode = 'n', '<cmd>ISwapWithRight<cr>', desc = 'ISwap - ISwapWithRight' },
    { '<leader>dh', mode = 'n', '<cmd>ISwapWithLeft<cr>', desc = 'ISwap - ISwapWithLeft' },
  },
}
