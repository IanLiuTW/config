return {
  'folke/zen-mode.nvim',
  keys = {
    { '<leader>,<space>', '<cmd>ZenMode<CR>', desc = '[ ] Zen Mode' },
  },
  opts = {
    window = {
      backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      width = 120, -- width of the Zen window
    },
    plugins = {
      twilight = { enabled = true },
      gitsigns = { enabled = true },
    },
  },
}
