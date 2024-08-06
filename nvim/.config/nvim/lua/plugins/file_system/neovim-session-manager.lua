return {
  {
    'Shatur/neovim-session-manager',
    config = function()
      -- local config = require 'session_manager.config'
      -- require('session_manager').setup {
      --   autoload_mode = config.AutoloadMode.GitSession,
      -- }
      -- vim.keymap.set('n', '<leader>\\s', '<Cmd>SessionManager save_current_session<CR>', { desc = 'Session - [S]ave Current Session' })
      -- vim.keymap.set('n', '<leader>\\l', '<Cmd>SessionManager load_session<CR>', { desc = 'Session - [L]oad Session' })
      -- vim.keymap.set('n', '<leader>\\.', '<Cmd>SessionManager load_last_session<CR>', { desc = 'Session - Load [.] Last Session' })
      -- vim.keymap.set('n', '<leader>\\g', '<Cmd>SessionManager load_git_session<CR>', { desc = 'Session - Load [G]it Session' })
      -- vim.keymap.set('n', '<leader>\\d', '<Cmd>SessionManager delete_session<CR>', { desc = 'Session - [D]elete Session' })
    end,
  },
}
