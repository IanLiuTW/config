---@return table
local function alpha_dashboard_layout()
  ---@param sc string
  ---@param txt string
  ---@param keybind string?
  ---@param keybind_opts table?
  ---@param opts table?
  ---@return table

  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo1', { fg = '#311B92' }) -- Indigo
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo2', { fg = '#512DA8' }) -- Deep Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo3', { fg = '#673AB7' }) -- Deep Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo4', { fg = '#9575CD' }) -- Medium Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo5', { fg = '#B39DDB' }) -- Light Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo6', { fg = '#D1C4E9' }) -- Very Light Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardInfo', { fg = '#fa8ea7' })
  vim.api.nvim_set_hl(0, 'NeovimDashboardButtonVal', { fg = '#4b6eeb', bold = true })
  vim.api.nvim_set_hl(0, 'NeovimDashboardButtonKey', { fg = '#d1a428', bold = true })
  vim.api.nvim_set_hl(0, 'NeovimDashboardMRUTitle', { fg = '#0dd1b0', bold = true })

  local function button(sc, txt, keybind, keybind_opts, opts)
    local def_opts = {
      cursor = 3,
      align_shortcut = 'right',
      hl = 'NeovimDashboardButtonVal',
      hl_shortcut = 'NeovimDashboardButtonKey',
      width = 40,
      position = 'center',
    }
    opts = opts and vim.tbl_extend('force', def_opts, opts) or def_opts
    opts.shortcut = sc
    local sc_ = sc:gsub('%s', ''):gsub('SPC', '<Leader>')
    local on_press = function()
      local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. '<Ignore>', true, false, true)
      vim.api.nvim_feedkeys(key, 't', false)
    end
    if keybind then
      keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
      opts.keymap = { 'n', sc_, keybind, keybind_opts }
    end
    return { type = 'button', val = txt, on_press = on_press, opts = opts }
  end

  -- https://github.com/goolord/alpha-nvim/issues/105
  local lazycache = setmetatable({}, {
    __newindex = function(table, index, fn)
      assert(type(fn) == 'function')
      getmetatable(table)[index] = fn
    end,
    __call = function(table, index)
      return function()
        return table[index]
      end
    end,
    __index = function(table, index)
      local fn = getmetatable(table)[index]
      if fn then
        local value = fn()
        rawset(table, index, value)
        return value
      end
    end,
  })

  ---@return string
  lazycache.info = function()
    local plugins = #vim.tbl_keys(require('lazy').plugins())
    local v = vim.version()
    local datetime = os.date ' %Y-%m-%d ⋄  %H:%M:%S'
    local platform = vim.fn.has 'win32' == 1 and '' or ''
    return string.format('󰂖 %d Plugins ⋄ v%d.%d.%d @ %s ⋄ %s', plugins, v.major, v.minor, v.patch, platform, datetime)
  end

  --stylua: ignore
  ---@return table
  lazycache.menu = function()
    return {
      button('      n',        '  New file', '<cmd>ene<CR>'),
      button('      \\', '  File Browser'),
      button('      l',  '󰑓  Load Session', '<cmd>SessionManager load_session<CR>'),
      button('      .',  '  Load Last Session', '<cmd>SessionManager load_last_session<CR>'),
      button('      p',  '  Project Manager', "<cmd>lua require'telescope'.extensions.project.project{}<CR>"),
      button('SPC s f',  '  Search Files'),
      button('SPC s .',  '  Search Recent Files'),
      button('SPC s g',  '󰊄  Seach with Live Grep'),
      button('SPC s ,',  '  Seach Neovim Config'),
      button('SPC p L',  '󰂖  Show Lazy Plugin'),
      button('SPC p M',  '󰀬  Show Mason Plugin'),
      button('u',        '  Quick Update Plugins', '<cmd>Lazy sync<CR>'),
      button('q',        '󰅚  Quit', '<cmd>qa<CR>'),
    }
  end

  ---@return table
  lazycache.mru = function()
    local result = {}
    for _, filename in ipairs(vim.v.oldfiles) do
      if vim.loop.fs_stat(filename) ~= nil then
        local icon, hl = require('nvim-web-devicons').get_icon(filename, vim.fn.fnamemodify(filename, ':e'))
        local filename_short = string.sub(vim.fn.fnamemodify(filename, ':t'), 1, 30)
        if icon == nil then
          icon = ''
          hl = 'Comment'
        end
        table.insert(
          result,
          button(
            tostring(#result + 1),
            string.format('%s  %s', icon, filename_short),
            string.format('<Cmd>e %s<CR>', filename),
            nil,
            { hl = { { hl, 0, 3 }, { 'Normal', 5, #filename_short + 5 } } }
          )
        )
        if #result == 9 then
          break
        end
      end
    end
    return result
  end

  ---@return table
  lazycache.fortune = function()
    return require 'alpha.fortune'()
  end

  return {
    { type = 'button', val = '█' },
    { type = 'padding', val = 2 },
    {
      type = 'text',
      val = '   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      opts = { hl = 'NeovimDashboardLogo1', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      opts = { hl = 'NeovimDashboardLogo2', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      opts = { hl = 'NeovimDashboardLogo3', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      opts = { hl = 'NeovimDashboardLogo4', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      opts = { hl = 'NeovimDashboardLogo5', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      opts = { hl = 'NeovimDashboardLogo6', shrink_margin = false, position = 'center' },
    },
    { type = 'padding', val = 2 },
    {
      type = 'text',
      val = lazycache 'info',
      opts = { hl = 'NeovimDashboardInfo', position = 'center' },
    },
    { type = 'padding', val = 2 },
    {
      type = 'group',
      val = lazycache 'menu',
      opts = { spacing = 0 },
    },
    { type = 'padding', val = 2 },
    {
      type = 'text',
      val = '󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜 Recent Files 󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜󰇜',
      opts = {
        hl = 'NeovimDashboardMRUTitle',
        shrink_margin = false,
        position = 'center',
      },
    },
    { type = 'padding', val = 0 },
    {
      type = 'group',
      val = lazycache 'mru',
      opts = { spacing = 0 },
    },
    { type = 'padding', val = 1 },
    {
      type = 'text',
      val = lazycache 'fortune',
      opts = { hl = 'Conceal', position = 'center' },
    },
    { type = 'padding', val = 2 },
  }
end

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
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('alpha').setup(require('alpha.themes.theta').config)
    end,
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      require('zen-mode').setup {
        window = {
          width = 0.85, -- width will be 85% of the editor width
        },
      }
      vim.keymap.set('n', '<leader>zz', '<cmd>ZenMode<CR>', { desc = '[Z]en Mode' })
    end,
  },
  {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup()
      vim.keymap.set('n', '<leader>zt', '<cmd>Twilight<CR>', { desc = '[T]wilight' })
    end,
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local layout = alpha_dashboard_layout()
      require('alpha').setup { layout = layout }

      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          vim.api.nvim_set_hl(0, 'LoadingTimeResult', { fg = '#edd691' })
          local result = {
            type = 'text',
            val = '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms',

            opts = { hl = 'LoadingTimeResult', position = 'center' },
          }
          table.insert(layout, result)
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local lualine = require 'lualine'

      -- Color table for highlights
      -- stylua: ignore
      local colors = {
        bg       = '#202328',
        fg       = '#bbc2cf',
        yellow   = '#ECBE7B',
        cyan     = '#008080',
        darkblue = '#081633',
        green    = '#98be65',
        orange   = '#FF8800',
        violet   = '#a9a1e1',
        magenta  = '#c678dd',
        blue     = '#51afef',
        red      = '#ec5f67',
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand '%:t') ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand '%:p:h'
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      -- Config
      local config = {
        options = {
          -- Disable sections and component separators
          component_separators = '',
          section_separators = '',
          theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x at right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left {
        -- mode component
        'mode',
        color = function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
          }
          return { fg = 'black', bg = mode_color[vim.fn.mode()] }
        end,
        padding = { left = 2, right = 2 },
      }

      ins_left {
        -- filesize component
        'filesize',
        cond = conditions.buffer_not_empty,
      }

      ins_left {
        'filename',
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = 'bold' },
      }

      ins_left { 'location' }

      ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

      ins_left {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
      }

      -- Insert mid section. You can make any number of sections in neovim :)
      -- for lualine it's any number greater then 2
      ins_left {
        function()
          return '%='
        end,
      }

      ins_left {
        -- Lsp server name .
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:',
        color = { fg = '#ffffff', gui = 'bold' },
      }

      -- Add components to right sections
      ins_right {
        'o:encoding', -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
        'fileformat',
        fmt = string.upper,
        icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
        color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
        'branch',
        icon = '',
        color = { fg = colors.violet, gui = 'bold' },
      }

      ins_right {
        'diff',
        -- Is it me or the symbol for modified us really weird
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      }

      lualine.setup(config)
    end,
  },
}
