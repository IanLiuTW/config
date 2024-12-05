return {
  'olimorris/persisted.nvim',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('persisted').setup {
      autostart = true,
      autoload = true,
      on_autoload_no_session = function() end,
      allowed_dirs = {
        '~/config',
        '~/codebase',
        '~/work/',
        '~/self/',
      }, -- Table of dirs that the plugin will start and autoload from
      -- ignored_dirs = {
      --   { '~', exact = true },
      --   '~/.config',
      --   '~/.local/nvim',
      -- }, -- Table of dirs that are ignored for starting and autoloading

      follow_cwd = true, -- Change the session file to match any change in the cwd?
      use_git_branch = true, -- Include the git branch in the session file name?
      should_save = function()
        -- Do not save if the alpha dashboard is the current filetype
        if vim.bo.filetype == 'alpha' then
          return false
        end
        return true
      end,

      telescope = {
        mappings = { -- Mappings for managing sessions in Telescope
          copy_session = '<C-y>',
          change_branch = '<C-b>',
          delete_session = '<C-x>',
        },
        icons = { -- icons displayed in the Telescope picker
          selected = ' ',
          dir = '  ',
          branch = ' ',
        },
      },
    }
    require('telescope').load_extension 'persisted'

    -- load the session for the current directory
    vim.keymap.set('n', '<leader>,<CR>', '<cmd>SessionLoad<cr>', { desc = 'Persisted - Load CWD Session' })
    vim.keymap.set('n', '<leader>,.', '<cmd>SessionLoadLast<cr>', { desc = 'Persisted - Load Last Session' })
    vim.keymap.set('n', '<leader>,/', '<cmd>Telescope persisted<cr>', { desc = 'Persisted - Search Sessions' })
    vim.keymap.set('n', '<leader>,l', ':SessionLoadFromFile ', { desc = 'Persisted - Save Session' })
    vim.keymap.set('n', '<leader>,s', '<cmd>SessionSave<cr>', { desc = 'Persisted - Save Session' })
    vim.keymap.set('n', '<leader>,\\', '<cmd>SessionToggle<cr>', { desc = 'Persisted - Toggle Session' })
  end,
}
