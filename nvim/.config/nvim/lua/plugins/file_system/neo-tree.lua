return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
    },
    opts = {
      source_selector = {
        winbar = true,
        statusline = false,
      },
      close_if_last_window = true,
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
            ['<C-s>'] = 'open_split',
            ['<C-v>'] = 'open_vsplit',
            ['<C-t>'] = 'open_tabnew',
            ['<cr>'] = 'open',
            ['<C-l>'] = 'open',
            ['<C-h>'] = 'close_node',
            ['l'] = 'open',
            ['h'] = 'close_node',
            ['<space>'] = 'toggle_node',
            ['<Tab>'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
            ['<C-Tab>'] = 'focus_preview',
            ['gh'] = { 'toggle_hidden' },
            ['[c'] = 'prev_git_modified',
            [']c'] = 'next_git_modified',
            ['[g'] = '',
            [']g'] = '',
            ['o'] = '',
            ['s'] = '',
            ['S'] = '',
            ['C'] = '',
            ['H'] = '',
            ['P'] = '',
            ['t'] = '',
          },
        },
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          always_show = {
            '.gitignore',
          },
          never_show = {},
          hide_by_name = {
            '.git',
            '.DS_Store',
            -- 'thumbs.db',
          },
        },
      },
    },
  },
}
