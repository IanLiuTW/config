-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
  },
  opts = {
    -- close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['s'] = 'open_split',
          ['v'] = 'open_vsplit',
          ['<2-LeftMouse>'] = 'open',
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['<CR>'] = 'toggle_node',
          ['<space>'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
          ['K'] = 'focus_preview',
          ['<c-h>'] = { 'toggle_hidden'}
        },
      },
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        always_show = { -- remains visible even if other settings would normally hide it
          '.gitignored',
        },
        never_show = {},
        hide_by_name = {
          '.git',
          -- '.DS_Store',
          -- 'thumbs.db',
        },
      },
    },
  },
}
