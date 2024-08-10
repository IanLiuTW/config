return {
  'folke/twilight.nvim',
  keys = {
    { '<leader>z\\', '<cmd>Twilight<CR>', desc = '[\\] Twilight' },
  },
  opts = {
    dimming = {
      alpha = 0.4,
    },
    context = 15,
  },
}
