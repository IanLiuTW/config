return {
  {
    'Shatur/neovim-session-manager',
    config = function()
      local config = require 'session_manager.config'
      require('session_manager').setup {
        autoload_mode = config.AutoloadMode.GitSession,
      }

      vim.keymap.set('n', '<leader>ps', '<Cmd>SessionManager save_current_session<CR>', { desc = '[S]ave current session' })
      vim.keymap.set('n', '<leader>pl', '<Cmd>SessionManager load_session<CR>', { desc = '[L]oad session' })
      vim.keymap.set('n', '<leader>p.', '<Cmd>SessionManager load_last_session<CR>', { desc = '[.] Load last session' })
      vim.keymap.set('n', '<leader>pd', '<Cmd>SessionManager delete_session<CR>', { desc = '[D]elete session' })
    end,
  },
}
