return {
  'coffebar/neovim-project',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
    { 'Shatur/neovim-session-manager' },
  },
  lazy = false,
  priority = 100,
  opts = {
    projects = { -- define project roots
      '~/config',
      '~/codebase',
      '~/work/*/*',
      '~/self/*/*',
    },
    last_session_on_startup = false,
    dashboard_mode = false,
    session_manager_opts = {
      autosave_ignore_dirs = {
        vim.fn.expand '~', -- don't create a session for $HOME/
        '/tmp',
      },
      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved
        'gitcommit',
        'gitrebase',
        'toggleterm',
      },
    },
  },
  keys = {
    { '<leader>z.', '<cmd>NeovimProjectLoadRecent<cr>', desc = 'Project - Load Last Project' },
    { '<leader>zp', '<cmd>Telescope neovim-project history<cr>', desc = 'Project - Load Project from History' },
    { '<leader>zP', '<cmd>Telescope neovim-project discover<cr>', desc = 'Project - Load Project from Discovery' },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
}
