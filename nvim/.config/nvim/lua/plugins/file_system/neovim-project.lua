return {
  'coffebar/neovim-project',
  opts = {
    projects = { -- define project roots
      '~/config',
      '~/codebase',

      '~/workspace_tupl/LLM/*',
      '~/workspace_tupl/NETADV/*',
      '~/workspace_tupl/VEA/*',
      '~/workspace_tupl/dev/*',
      '~/workspace_tupl/side/*',

      '~/workspace_playground/playground/*',
      '~/workspace_playground/rust/*',
    },
    dashboard_mode = true,
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
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
    { 'Shatur/neovim-session-manager' },
  },
  lazy = false,
  priority = 100,
}
