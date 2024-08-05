return {
  'Wansmer/treesj',
  keys = {
    {
      '<space>c<',
      '<Cmd>TSJJoin<CR>',
      desc = 'TreeSJ - Join',
    },
    {
      '<space>c>',
      '<Cmd>TSJSplit<CR>',
      desc = 'TreeSJ - Split',
    },
    {
      '<space>cm',
      '<Cmd>TSJToggle<CR>',
      desc = 'TreeSJ - Toggle',
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
