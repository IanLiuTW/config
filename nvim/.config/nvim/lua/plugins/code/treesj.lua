return {
  'Wansmer/treesj',
  keys = {
    {
      '<leader>d<',
      '<Cmd>TSJJoin<CR>',
      desc = 'TreeSJ - Join',
      mode = {'n', 'v'}
    },
    {
      '<leader>d>',
      '<Cmd>TSJSplit<CR>',
      desc = 'TreeSJ - Split',
      mode = {'n', 'v'}
    },
    {
      '<leader>d,',
      '<Cmd>TSJToggle<CR>',
      desc = 'TreeSJ - Toggle',
      mode = {'n', 'v'}
    },
    {
      '<leader>d.',
      function()
        require('treesj').toggle { split = { recursive = true } }
      end,
      desc = 'TreeSJ - Toggle (Recursive)',
    },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup {
      use_default_keymaps = false,
      max_join_length = 1000,
    }
  end,
}
