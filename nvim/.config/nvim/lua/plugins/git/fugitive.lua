return {
  'tpope/vim-fugitive',
  lazy = false,
  keys = {
    { '<leader>gg', '<cmd>Git<cr>', desc = 'Fugitive - Open' },
    { '<leader>gG', '<cmd>tab Git<cr>', desc = 'Fugitive - Open in New Tab' },
    { '<leader>gB', '<cmd>Git blame<cr>', desc = 'Fugitive - Open [B]lame Info' },
    {
      '<leader>gc',
      function()
        vim.ui.input({ prompt = 'Enter a branch to compare: ' }, function(input)
          if input then
            vim.cmd('Gdiffsplit ' .. input)
          else
            vim.cmd 'Gdiffsplit origin/master'
          end
        end)
      end,
      desc = 'Fugitive - [C]ompare Branches',
    },
  },
}
