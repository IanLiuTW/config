return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<F2>', '<cmd>AutoSession search<CR>', desc = 'Auto-Session - Session search' },
    { '<leader>,s', '<cmd>AutoSession save<CR>', desc = 'Auto-Session - Save session' },
    { '<leader>,S', '<cmd>AutoSession toggle<CR>', desc = 'Auto-Session - Toggle autosave' },
  },

  opts = {
    auto_create = function()
      local cmd = 'git rev-parse --is-inside-work-tree'
      return vim.fn.system(cmd) == 'true\n'
    end,

    cwd_change_handling = true,
    pre_cwd_changed_cmds = {},
    post_cwd_changed_cmds = {
      function()
        require('lualine').refresh()
      end,
    },

    -- suppressed_dirs = { '~/', '/', '~/Downloads' }, -- Suppress session restore/create in certain directories
    -- allowed_dirs = { '~/config', '~/codebase', '~/work/*', '~/self/*' }, -- Allow session restore/create in certain directories
    bypass_save_filetypes = { 'snacks_dashboard' }, -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
    close_filetypes_on_save = { 'checkhealth' }, -- Buffers with matching filetypes will be closed before saving

    git_use_branch_name = true, -- Include git branch name in session name, can also be a function that takes an optional path and returns the name of the branch
    git_auto_restore_on_branch_change = true, -- Should we auto-restore the session when the git branch changes. Requires git_use_branch_name

    auto_delete_empty_sessions = true, -- Enables/disables deleting the session if there are only unnamed/empty buffers when auto-saving
    purge_after_minutes = nil, -- Sessions older than purge_after_minutes will be deleted asynchronously on startup, e.g. set to 14400 to delete sessions that haven't been accessed for more than 10 days, defaults to off (no purging), requires >= nvim 0.10

    save_extra_data = nil, -- Function that returns extra data that should be saved with the session. Will be passed to restore_extra_data on restore
    restore_extra_data = nil, -- Function called when there's extra data saved for a session

    show_auto_restore_notif = false, -- Whether to show a notification when auto-restoring
    restore_error_handler = nil, -- Function called when there's an error restoring. By default, it ignores fold and help errors otherwise it displays the error and returns false to disable auto_save. Default handler is accessible as require('auto-session').default_restore_error_handler
    continue_restore_on_error = true, -- Keep loading the session even if there's an error
    lsp_stop_on_restore = false, -- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup

    session_lens = {
      picker = 'snacks',
      mappings = {
        delete_session = { { 'i', 'n' }, '<C-x>' },
        alternate_session = { { 'i', 'n' }, '<C-.>' },
        copy_session = { { 'i', 'n' }, '<C-a>' },
      },
    },
  },
}
