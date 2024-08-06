return {
  'Wansmer/treesj',
  keys = {
    {
      '<space>c<',
      '<Cmd>TSJJoin<CR>',
      desc = 'TreeSJ - Join',
      mode = {'n', 'v'}
    },
    {
      '<space>c>',
      '<Cmd>TSJSplit<CR>',
      desc = 'TreeSJ - Split',
      mode = {'n', 'v'}
    },
    {
      '<space>cm',
      '<Cmd>TSJToggle<CR>',
      desc = 'TreeSJ - Toggle',
      mode = {'n', 'v'}
    },
    {
      '<space>cM',
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
