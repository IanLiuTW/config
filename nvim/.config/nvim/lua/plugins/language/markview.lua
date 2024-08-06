return {
  'OXY2DEV/markview.nvim',
  ft = 'markdown',
  branch = 'main',
  dependencies = {
    -- You may not need this if you don't lazy load
    -- Or if the parsers are in your $RUNTIMEPATH
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>zv', '<cmd>Markview toggle<cr>' },
  },
  config = function()
    require('markview').setup {
      modes = nil,
      hybrid_modes = { 'n', 'no' },
    }
  end,
}
