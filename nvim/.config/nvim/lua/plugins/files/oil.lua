return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<CMD>Oil --float<CR>', desc = 'Open Oil Float' },
      { '_', '<CMD>Oil<CR>', desc = 'Open Oil' },
    },
    opts = {
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['?'] = 'actions.show_help',
        ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
        ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
        ['<cr>'] = 'actions.select',
        ['<C-l>'] = 'actions.select',
        ['<C-h>'] = 'actions.parent',
        ['<Tab>'] = 'actions.preview',
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
      use_default_keymaps = false,
      win_options = {
        signcolumn = 'yes:2',
      },
      watch_for_changes = true,
    },
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = {
      'stevearc/oil.nvim',
    },
    config = true,
  },
}
