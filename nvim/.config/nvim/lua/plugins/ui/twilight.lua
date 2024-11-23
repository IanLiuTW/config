return {
  'folke/twilight.nvim',
  keys = {
    { '<leader>,<CR>', '<cmd>Twilight<CR>', desc = 'Twilight - Toggle' },
  },
  opts = {
    dimming = {
      alpha = 0.4,
    },
    context = 15,
  },
}
