return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<F2>', '<cmd>AutoSession search<CR>', desc = 'Session - Search' },
    { '<leader>,a', '<cmd>AutoSession save<CR>', desc = 'Session - Save' },
    { '<leader>,A', '<cmd>AutoSession toggle<CR>', desc = 'Session - Toggle autosave' },
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

    bypass_save_filetypes = { 'snacks_dashboard' },
    close_filetypes_on_save = { 'checkhealth' },

    git_use_branch_name = true,
    git_auto_restore_on_branch_change = true,

    auto_delete_empty_sessions = true,
    purge_after_minutes = nil,

    save_extra_data = nil,
    restore_extra_data = nil,

    show_auto_restore_notif = false,
    restore_error_handler = nil,
    continue_restore_on_error = true,
    lsp_stop_on_restore = false,

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
