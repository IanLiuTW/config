return {
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#000000',
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        routes = {
          {
            view = 'notify',
            filter = { event = 'msg_showmode' },
          },
          -- {
          --   filter = {
          --     event = 'msg_show',
          --     kind = '',
          --     find = 'written',
          --   },
          --   opts = { skip = true },
          -- },
          {
            filter = {
              event = 'lsp',
              kind = 'progress',
              cond = function(message)
                local client = vim.tbl_get(message.opts, 'progress', 'client')
                return client == 'lua_ls'
              end,
            },
            opts = { skip = true },
          },
        },
        views = {
          cmdline_popup = {
            border = {
              style = 'none',
              padding = { 2, 3 },
            },
            filter_options = {},
            win_options = {
              winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
            },
          },
        },
      }
    end,
  },
  {
    {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
        require('window-picker').setup()
      end,
    },
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      icons = {
        buffer_number = true,
      },
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  }
}
