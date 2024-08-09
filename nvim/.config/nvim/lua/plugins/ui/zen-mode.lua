return {
  'folke/zen-mode.nvim',
  keys = {
    { '<leader>z<space>', '<cmd>ZenMode<CR>', desc = '[ ] Zen Mode' },
  },
  opts = {
    window = {
      width = 0.85, -- width will be 85% of the editor width
    },
  },
}
