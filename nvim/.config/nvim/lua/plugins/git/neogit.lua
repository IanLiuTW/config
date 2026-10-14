return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'm00qek/baleia.nvim',
    'esmuellert/codediff.nvim',
    'folke/snacks.nvim',
  },
  keys = {
    { '<leader>gg', '<Cmd>Neogit<CR>', desc = 'Git - Neogit' },
    { '<leader>gc', '<Cmd>Neogit commit<CR>', desc = 'Git - Commit' },
    { '<leader>gZ', '<Cmd>Neogit stash<CR>', desc = 'Git - Stash (Neogit)' },
    { '<leader>gf', '<Cmd>Neogit fetch<CR>', desc = 'Git - Fetch' },
    { '<leader>gp', '<Cmd>Neogit pull<CR>', desc = 'Git - Pull' },
    { '<leader>gP', '<Cmd>Neogit push<CR>', desc = 'Git - Push' },
  },
  opts = {
    disable_hint = false,
    disable_context_highlighting = false,
    disable_signs = false,
    disable_insert_on_commit = true,
    filewatcher = {
      interval = 1000,
      enabled = true,
    },
    remember_settings = true,
    use_per_project_settings = true,
    -- Never remember these switches between runs
    ignored_settings = {
      'NeogitPushPopup--force-with-lease',
      'NeogitPushPopup--force',
      'NeogitPullPopup--rebase',
      'NeogitCommitPopup--allow-empty',
      'NeogitRevertPopup--no-edit',
    },
    highlight = {
      italic = true,
      bold = true,
      underline = true,
    },
    use_default_keymaps = true,
    auto_refresh = true,
    sort_branches = '-committerdate',
    kind = 'tab',
    disable_line_numbers = true,
    console_timeout = 2000,
    auto_show_console = true,
    graph_style = 'unicode',
    -- baleia (set up in config) colors the ANSI output of delta
    log_pager = { 'delta', '--width', '117', '--file-style=omit', '--file-decoration-style=omit', '--hunk-header-style=omit', '--hunk-header-decoration-style=omit' },
    process_spinner = true,
    auto_close_console = true,
    status = {
      show_head_commit_hash = true,
      recent_commit_count = 10,
      HEAD_padding = 10,
      HEAD_folded = false,
      mode_padding = 3,
      mode_text = {
        M = 'modified',
        N = 'new file',
        A = 'added',
        D = 'deleted',
        C = 'copied',
        U = 'updated',
        R = 'renamed',
        DD = 'unmerged',
        AU = 'unmerged',
        UD = 'unmerged',
        UA = 'unmerged',
        DU = 'unmerged',
        AA = 'unmerged',
        UU = 'unmerged',
        ['?'] = '',
      },
    },
    commit_editor = {
      kind = 'tab',
      show_staged_diff = true,
      staged_diff_split_kind = 'auto',
    },
    commit_select_view = {
      kind = 'tab',
    },
    commit_view = {
      kind = 'vsplit',
      verify_commit = vim.fn.executable 'gpg' == 1,
    },
    log_view = {
      kind = 'tab',
    },
    rebase_editor = {
      kind = 'auto',
    },
    reflog_view = {
      kind = 'tab',
    },
    merge_editor = {
      kind = 'auto',
    },
    tag_editor = {
      kind = 'auto',
    },
    preview_buffer = {
      kind = 'split',
    },
    popup = {
      kind = 'split',
    },
    signs = {
      -- { closed, open }
      hunk = { '⤑', '⇣' },
      item = { '', '' },
      section = { '󰝤', '' },
    },
    integrations = {
      diffview = false,
      codediff = true,
      snacks = true,
    },
    diff_viewer = 'codediff',
    sections = {
      -- Revert or cherry-pick in progress
      sequencer = {
        folded = false,
        hidden = false,
      },
      untracked = {
        folded = false,
        hidden = false,
      },
      unstaged = {
        folded = false,
        hidden = false,
      },
      staged = {
        folded = false,
        hidden = false,
      },
      stashes = {
        folded = true,
        hidden = false,
      },
      unpulled_upstream = {
        folded = false,
        hidden = false,
      },
      unmerged_upstream = {
        folded = false,
        hidden = false,
      },
      unpulled_pushRemote = {
        folded = false,
        hidden = false,
      },
      unmerged_pushRemote = {
        folded = false,
        hidden = false,
      },
      recent = {
        folded = true,
        hidden = false,
      },
      rebase = {
        folded = false,
        hidden = false,
      },
    },
    mappings = {
      commit_editor = {
        ['q'] = 'Close',
        ['<c-cr>'] = 'Submit',
        ['<c-q>'] = 'Abort',
        ['<c-p>'] = 'PrevMessage',
        ['<c-n>'] = 'NextMessage',
        ['<c-r>'] = 'ResetMessage',
      },
      commit_editor_I = {
        ['<c-cr>'] = 'Submit',
        ['<c-q>'] = 'Abort',
      },
      rebase_editor = {
        ['<c-cr>'] = 'Submit',
        ['<c-q>'] = 'Abort',
        ['<c-b>'] = 'OpenOrScrollUp',
        ['<c-f>'] = 'OpenOrScrollDown',
      },
      rebase_editor_I = {
        ['<c-cr>'] = 'Submit',
        ['<c-q>'] = 'Abort',
      },
      status = {
        ['<space>'] = 'Toggle',
        ['za'] = false,
        ['<S-tab>'] = 'PeekFile',
        ['!'] = 'Command',
        ['Q'] = false,
      },
    },
  },
  config = function(_, opts)
    vim.g.baleia = require('baleia').setup {}
    require('neogit').setup(opts)
  end,
}
