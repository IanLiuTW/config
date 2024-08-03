return {
  'tpope/vim-fugitive',
  lazy = true,
  event = 'BufRead',
  keys = {
    { '<leader>gf', '<cmd>Git<cr>', desc = '[F]ugitive - Open' },
    { '<leader>gF', '<cmd>tab Git<cr>', desc = '[F]ugitive - Open in New Tab' },
  }
}
