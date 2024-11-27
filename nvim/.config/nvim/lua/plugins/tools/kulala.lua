return {
  'mistweaverco/kulala.nvim',
  opts = { default_view = 'headers_body' },
  keys = {
    {
      '<leader>rk',
      "<Cmd>lua require('kulala').scratchpad()<CR>",
      desc = 'Kulala - Open Scratchpad',
    },
  },
}
