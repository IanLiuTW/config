return {
  'OXY2DEV/markview.nvim',
  lazy = true,
  ft = 'markdown',
  branch = 'main',
  dependencies = {
    -- You may not need this if you don't lazy load
    -- Or if the parsers are in your $RUNTIMEPATH
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>zv', '<cmd>Markview splitToggle<cr>', desc = 'Toggle Markview' },
  },
  config = function()
    require('markview').setup {
      initial_state = false,
      highlight_groups = 'dynamic',
      modes = { 'n', 'i', 'no', 'c' },
      hybrid_modes = { 'i' },

      -- This is nice to have
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].concealcursor = 'nc'
        end,
      },
    }
  end,
}
