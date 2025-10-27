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
      },
      watch_for_changes = true,
      use_default_keymaps = false,
      keymaps = {
        ['?'] = 'actions.show_help',
        ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
        ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
        ['<cr>'] = 'actions.select',
        ['<C-l>'] = 'actions.select',
        ['<C-h>'] = 'actions.parent',
        ['<S-Tab>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['-'] = 'actions.close',
        ['R'] = 'actions.refresh',
        ['\\'] = 'actions.open_cwd',
        ['.'] = 'actions.cd',
        [','] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
        ['gx'] = 'actions.open_external',
        ['go'] = 'actions.change_sort',
        ['gh'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },
      float = {
        padding = 1,
        border = 'rounded',
      },
    },
  },
  {
    'benomahony/oil-git.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {
      highlights = {
        OilGitAdded = { fg = '#a6e3a1' }, -- green
        OilGitModified = { fg = '#fcbc2d' }, -- yellow
        OilGitRenamed = { fg = '#cba6f7' }, -- purple
        OilGitUntracked = { fg = '#89b4fa' }, -- blue
        OilGitIgnored = { fg = '#6c7086' }, -- gray
      },
    },
  },
}
