return {
  'tpope/vim-fugitive',
  event = 'BufRead',
  keys = {
      { '<leader>gf', '<cmd>Git<cr>', desc = '[G]it [F]ugitive' },
      { '<leader>gF', '<cmd>tab Git<cr>', desc = '[G]it [F]ugitive' },
  }
}
