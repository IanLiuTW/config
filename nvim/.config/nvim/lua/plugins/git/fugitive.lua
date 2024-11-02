return {
  'tpope/vim-fugitive',
  lazy = false,
  keys = {
    { '<leader>gf', '<cmd>Git<cr>', desc = '[F]ugitive - Open' },
    { '<leader>gF', '<cmd>tab Git<cr>', desc = '[F]ugitive - Open in New Tab' },
    { '<leader>gB', '<cmd>Git blame<cr>', desc = '[F]ugitive - Open [B]lame Info' },
  }
}
