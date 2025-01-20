return {
  'NeogitOrg/neogit',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>gg', '<Cmd>Neogit<CR>', desc = 'NeoGit - Open' },
    { '<leader>gc', '<Cmd>Neogit commit<CR>', desc = 'NeoGit - Commit Panel' },
    { '<leader>gZ', '<Cmd>Neogit stash<CR>', desc = 'NeoGit - Stash Panel' },
    { '<leader>gf', '<Cmd>Neogit fetch<CR>', desc = 'NeoGit - Fetch Panel' },
    { '<leader>gp', '<Cmd>Neogit pull<CR>', desc = 'NeoGit - Pull Panel' },
    { '<leader>gP', '<Cmd>Neogit push<CR>', desc = 'NeoGit - Push Panel' },
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
    graph_style = 'unicode',
    git_services = { -- Used to generate URL's for branch popup action "pull request".
      ['github.com'] = 'https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1',
      ['bitbucket.org'] = 'https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1',
      ['gitlab.com'] = 'https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}',
      ['azure.com'] = 'https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}',
    },
    -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
    -- sorter instead. By default, this function returns `nil`.
    telescope_sorter = function()
      return require('telescope').extensions.fzf.native_fzf_sorter()
    end,
    -- Persist the values of switches/options within and across sessions
    remember_settings = true,
    -- Scope persisted settings on a per-project basis
    use_per_project_settings = true,
    -- Table of settings to never persist. Uses format "Filetype--cli-value"
    ignored_settings = {
      'NeogitPushPopup--force-with-lease',
      'NeogitPushPopup--force',
      'NeogitPullPopup--rebase',
      'NeogitCommitPopup--allow-empty',
      'NeogitRevertPopup--no-edit',
    },
    -- Configure highlight group features
    highlight = {
      italic = true,
      bold = true,
      underline = true,
    },
    -- Set to false if you want to be responsible for creating _ALL_ keymappings
    use_default_keymaps = false,
    -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    auto_refresh = true,
    -- Value used for `--sort` option for `git branch` command
    -- By default, branches will be sorted by commit date descending
    -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
    -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
    sort_branches = '-committerdate',
    -- Change the default way of opening neogit
    kind = 'tab',
    -- Disable line numbers and relative line numbers
    disable_line_numbers = true,
    -- The time after which an output console is shown for slow running commands
    console_timeout = 2000,
    -- Automatically show console if a command takes more than console_timeout milliseconds
    auto_show_console = true,
    -- Automatically close the console if the process exits with a 0 (success) status
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
      -- Accepted values:
      -- "split" to show the staged diff below the commit editor
      -- "vsplit" to show it to the right
      -- "split_above" Like :top split
      -- "vsplit_left" like :vsplit, but open to the left
      -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
      -- ""
      show_staged_diff = true,
      staged_diff_split_kind = 'auto',
    },
    commit_select_view = {
      kind = 'tab',
    },
    commit_view = {
      kind = 'vsplit',
      verify_commit = vim.fn.executable 'gpg' == 1, -- Can be set to true or false, otherwise we try to find the binary
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
      -- { CLOSED, OPENED }
      hunk = { '⤑', '⇣' },
      item = { '', '' },
      section = { '󰝤', '' },
    },
    -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
    integrations = {
      -- If enabled, use telescope for menu selection rather than vim.ui.select.
      -- Allows multi-select and some things that vim.ui.select doesn't.
      telescope = true,
      -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
      -- The diffview integration enables the diff popup.
      --
      -- Requires you to have `sindrets/diffview.nvim` installed.
      diffview = true,

      -- If enabled, uses fzf-lua for menu selection. If the telescope integration
      -- is also selected then telescope is used instead
      -- Requires you to have `ibhagwan/fzf-lua` installed.
      fzf_lua = nil,
    },
    sections = {
      -- Reverting/Cherry Picking
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
        ['<c-y>'] = 'Submit',
        ['<c-e>'] = 'Abort',
        ['<c-p>'] = 'PrevMessage',
        ['<c-n>'] = 'NextMessage',
        ['<c-r>'] = 'ResetMessage',
      },
      commit_editor_I = {
        ['<c-y>'] = 'Submit',
        ['<c-e>'] = 'Abort',
      },
      rebase_editor = {
        ['p'] = 'Pick',
        ['r'] = 'Reword',
        ['e'] = 'Edit',
        ['s'] = 'Squash',
        ['f'] = 'Fixup',
        ['x'] = 'Execute',
        ['d'] = 'Drop',
        ['b'] = 'Break',
        ['q'] = 'Close',
        ['<cr>'] = 'OpenCommit',
        ['<c-l>'] = 'OpenCommit',
        ['<c-k>'] = 'MoveUp',
        ['<c-j>'] = 'MoveDown',
        ['<c-y>'] = 'Submit',
        ['<c-e>'] = 'Abort',
        ['<c-b>'] = 'OpenOrScrollUp',
        ['<c-f>'] = 'OpenOrScrollDown',
      },
      rebase_editor_I = {
        ['<c-y>'] = 'Submit',
        ['<c-e>'] = 'Abort',
      },
      finder = {
        ['<cr>'] = 'Select',
        ['<c-c>'] = 'Close',
        ['<esc>'] = 'Close',
        ['<c-n>'] = 'Next',
        ['<c-p>'] = 'Previous',
        ['<down>'] = 'Next',
        ['<up>'] = 'Previous',
        ['<tab>'] = 'MultiselectToggleNext',
        ['<s-tab>'] = 'MultiselectTogglePrevious',
        ['<c-j>'] = 'NOP',
      },
      -- Setting any of these to `false` will disable the mapping.
      popup = {
        ['?'] = 'HelpPopup',
        ['A'] = 'CherryPickPopup',
        ['B'] = 'BisectPopup',
        ['b'] = 'BranchPopup',
        ['c'] = 'CommitPopup',
        ['d'] = 'DiffPopup',
        ['f'] = 'FetchPopup',
        ['i'] = 'IgnorePopup',
        ['l'] = 'LogPopup',
        ['m'] = 'MergePopup',
        ['M'] = 'RemotePopup',
        ['p'] = 'PullPopup',
        ['P'] = 'PushPopup',
        ['r'] = 'RebasePopup',
        ['t'] = 'TagPopup',
        ['v'] = 'RevertPopup',
        ['w'] = 'WorktreePopup',
        ['X'] = 'ResetPopup',
        ['Z'] = 'StashPopup',
      },
      status = {
        ['k'] = 'MoveUp',
        ['j'] = 'MoveDown',
        ['q'] = 'Close',
        ['o'] = 'OpenTree',
        ['I'] = 'InitRepo',
        ['1'] = 'Depth1',
        ['2'] = 'Depth2',
        ['3'] = 'Depth3',
        ['4'] = 'Depth4',
        ['<space>'] = 'Toggle',
        ['-'] = 'Toggle',
        ['x'] = 'Discard',
        ['s'] = 'Stage',
        ['S'] = 'StageUnstaged',
        ['a'] = 'StageAll',
        ['K'] = 'Untrack',
        ['u'] = 'Unstage',
        ['U'] = 'UnstageStaged',
        ['$'] = 'CommandHistory',
        [':'] = 'Command',
        ['`'] = 'ShowRefs',
        ['Y'] = 'YankSelected',
        ['R'] = 'RefreshBuffer',
        ['<cr>'] = 'GoToFile',
        ['<tab>'] = 'PeekFile',
        ['<c-v>'] = 'VSplitOpen',
        ['<c-s>'] = 'SplitOpen',
        ['<c-t>'] = 'TabOpen',
        ['[c'] = 'GoToPreviousHunkHeader',
        [']c'] = 'GoToNextHunkHeader',
        ['<c-b>'] = 'OpenOrScrollUp',
        ['<c-f>'] = 'OpenOrScrollDown',
        ['<c-k>'] = 'PeekUp',
        ['<c-j>'] = 'PeekDown',
      },
    },
  },
}
