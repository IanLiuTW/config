local permission_hlgroups = {
  ['-'] = 'NonText',
  ['r'] = 'DiagnosticSignWarn',
  ['w'] = 'DiagnosticSignError',
  ['x'] = 'DiagnosticSignOk',
}

return {
  {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<CMD>Oil --float<CR>', desc = 'Open Oil Float' },
      { '_', '<CMD>Oil<CR>', desc = 'Open Oil' },
    },
    opts = {
      columns = {
        {
          'permissions',
          highlight = function(permission_str)
            local hls = {}
            for i = 1, #permission_str do
              local char = permission_str:sub(i, i)
              table.insert(hls, { permission_hlgroups[char], i - 1, i })
            end
            return hls
          end,
        },
        { 'size', highlight = 'Special' },
        { 'mtime', highlight = 'Number' },
        {
          'icon',
          add_padding = false,
        },
      },
      view_options = {
        show_hidden = true,
      },
      win_options = {
        signcolumn = 'yes:2',
        statuscolumn = '',
      },
      confirmation = {
        border = 'rounded',
      },
      watch_for_changes = true,
      use_default_keymaps = false,
      keymaps = {
        ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
        ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
        ['<CR>'] = 'actions.select',
        ['l'] = 'actions.select',
        ['h'] = 'actions.parent',
        ['<S-Tab>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['-'] = 'actions.close',
        ['_'] = 'actions.close',
        ['R'] = 'actions.refresh',
        ['`'] = 'actions.cd',
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
        ['.'] = 'actions.open_cwd',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
        ['g<CR>'] = 'actions.open_external',
        ['gs'] = 'actions.change_sort',
        ['g?'] = 'actions.show_help',
      },
      float = {
        padding = 3,
        border = 'rounded',
      },
    },
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {
      show_ignored = false,
    },
    config = function(_, opts)
      require('oil-git-status').setup(opts)
      -- colors from the teide-dark palette
      vim.api.nvim_set_hl(0, 'OilGitStatusIndex', { fg = '#38FFA5' }) -- staged: green
      vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTree', { fg = '#FFE77A' }) -- unstaged: yellow
      vim.api.nvim_set_hl(0, 'OilGitStatusIndexUntracked', { fg = '#5CCEFF' }) -- untracked: blue
      vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeUntracked', { fg = '#5CCEFF' })
      vim.api.nvim_set_hl(0, 'OilGitStatusIndexRenamed', { fg = '#A592FF' }) -- renamed: purple
      vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeRenamed', { fg = '#A592FF' })
    end,
  },
}
