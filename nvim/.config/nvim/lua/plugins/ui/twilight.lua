return {
  'folke/twilight.nvim',
  keys = {
    { '<leader>zt', '<cmd>Twilight<CR>', desc = '[T]wilight' },
  },
  opts = {
    dimming = {
      alpha = 0.4,
    },
    context = 15,
  },
}
