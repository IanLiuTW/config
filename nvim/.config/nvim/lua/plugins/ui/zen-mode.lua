return {
  'folke/zen-mode.nvim',
  keys = {
    { '<leader>zz', '<cmd>ZenMode<CR>', desc = '[Z]en Mode' },
  },
  opts = {
    window = {
      width = 0.85, -- width will be 85% of the editor width
    },
  },
}
