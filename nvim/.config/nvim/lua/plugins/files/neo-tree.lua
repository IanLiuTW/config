return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = false,
    version = '*',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      -- '3rd/image.nvim',
    },
    cmd = 'Neotree',
    -- keys = {
    --   { '\\', '<CMD>Neotree reveal<CR>', desc = 'NeoTree reveal' },
    -- },
    opts = {
      source_selector = {
        winbar = true,
        statusline = false,
      },
      close_if_last_window = false,
      use_libuv_file_watcher = true,
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
            ['<C-s>'] = 'open_split',
            ['<C-v>'] = 'open_vsplit',
            ['<C-t>'] = 'open_tabnew',
            ['<cr>'] = 'open',
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
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require 'neo-tree.events'
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require('neo-tree').setup(opts)
    end,
  },
}
