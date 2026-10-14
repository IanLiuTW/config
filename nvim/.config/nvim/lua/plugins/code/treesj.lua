return {
  'Wansmer/treesj',
  lazy = true,
  keys = {
    {
      '<leader>d<',
      '<Cmd>TSJJoin<CR>',
      desc = 'Edit - Join node',
      mode = {'n', 'v'}
    },
    {
      '<leader>d>',
      '<Cmd>TSJSplit<CR>',
      desc = 'Edit - Split node',
      mode = {'n', 'v'}
    },
    {
      '<leader>d,',
      '<Cmd>TSJToggle<CR>',
      desc = 'Edit - Toggle split / join',
      mode = {'n', 'v'}
    },
    {
      '<leader>d.',
      function()
        require('treesj').toggle { split = { recursive = true } }
      end,
      desc = 'Edit - Toggle split / join (recursive)',
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
