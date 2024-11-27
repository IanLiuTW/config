return {
  'folke/persistence.nvim',
  event = 'VimEnter',
  config = function()
    require('persistence').setup {}

    -- load the session for the current directory
    vim.keymap.set('n', '<leader>,<CR>', function()
      require('persistence').load()
    end, { desc = 'Persistence - Load CWD Session' })
    -- select a session to load
    vim.keymap.set('n', '<leader>,/', function()
      require('persistence').select()
    end, { desc = 'Persistence - Select Session' })
    -- load the last session
    vim.keymap.set('n', '<leader>,.', function()
      require('persistence').load { last = true }
    end, { desc = 'Persistence - Load Last Session' })
    -- stop Persistence => session won't be saved on exit
    vim.keymap.set('n', '<leader>,?', function()
      require('persistence').stop()
    end, { desc = 'Persistence - Stop Saving Session' })
  end,
}
