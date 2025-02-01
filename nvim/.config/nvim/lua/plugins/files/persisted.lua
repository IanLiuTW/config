return {
  'olimorris/persisted.nvim',
  event = 'VimEnter',
  keys = {
    { '<leader>,r', '<cmd>SessionLoad<cr>', desc = 'Persisted - Restore CWD Session' },
    { '<leader>,.', '<cmd>SessionLoadLast<cr>', desc = 'Persisted - Restore Last Session' },
    { '<leader>,l', ':SessionLoadFromFile ', desc = 'Persisted - Load Session From File' },
    { '<leader>,s', '<cmd>SessionSave<cr>', desc = 'Persisted - Save Session' },
    { '<leader>,\\', '<cmd>SessionToggle<cr>', desc = 'Persisted - Toggle Session' },
  },
  config = function()
    require('persisted').setup {
      autostart = true,
      autoload = false,
      on_autoload_no_session = function()
        vim.notify 'No session found for this directory'
      end,
      -- allowed_dirs = {
      --   '~/config',
      --   '~/codebase',
      --   '~/work/',
      --   '~/self/',
      -- }, -- Table of dirs that the plugin will start and autoload from
      ignored_dirs = {
        { '~', exact = true },
        '~/.config',
        -- '~/.local/nvim',
      }, -- Table of dirs that are ignored for starting and autoloading

      follow_cwd = true, -- Change the session file to match any change in the cwd?
      use_git_branch = true, -- Include the git branch in the session file name?
      should_save = function()
        if vim.bo.filetype == 'snacks_dashboard' then
          return false
        end
        return true
      end,
    }
  end,
}
