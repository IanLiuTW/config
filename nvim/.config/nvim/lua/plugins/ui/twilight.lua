return {
  'folke/twilight.nvim',
  lazy = true,
  keys = {
    { '<leader>,x', '<cmd>Twilight<CR>', desc = 'Twilight - Toggle' },
  },
  opts = {
    dimming = {
      alpha = 0.4,
    },
    context = 15,
  },
}
