return {
  'mizlan/iswap.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>Sb', mode = 'n', ':ISwap<cr>', desc = 'ISwap - ISwap' },
    { '<leader>Ss', mode = 'n', ':ISwapWith<cr>', desc = 'ISwap - ISwapWith' },
    { '<leader>Sl', mode = 'n', ':ISwapWithRight<cr>', desc = 'ISwap - ISwapWithRight' },
    { '<leader>Sh', mode = 'n', ':ISwapWithLeft<cr>', desc = 'ISwap - ISwapWithLeft' },
  },
}
