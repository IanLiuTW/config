---@return table
local function alpha_dashboard_layout()
  ---@param sc string
  ---@param txt string
  ---@param keybind string?
  ---@param keybind_opts table?
  ---@param opts table?
  ---@return table
  local function button(sc, txt, keybind, keybind_opts, opts)
    local def_opts = {
      cursor = 3,
      align_shortcut = 'right',
      hl = 'Title',
      hl_shortcut = 'WarningMsg',
      width = 50,
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
    local datetime = os.date ' %d-%m-%Y ⋄  %H:%M:%S'
    local platform = vim.fn.has 'win32' == 1 and '' or ''
    return string.format('󰂖 %d Plugins ⋄ v%d.%d.%d @ %s ⋄ %s', plugins, v.major, v.minor, v.patch, platform, datetime)
  end

  ---@return table
  lazycache.menu = function()
    return {
      button('SPC .  ', '  File Browser'),
      button('SPC s f', '  Find Files'),
      button('SPC s .', '  Find Recent Files'),
      button('SPC s g', '󰊄  Live Grep'),
      button('SPC ? ?', '  Find Repos'),
      button('SPC s n', '  Find Neovim Config'),
      button('SPC ? ?', '  Open Session'),
      button('n', '  New file', '<Cmd>ene<CR>'),
      button('p', '󰂖  Show Plugins', '<Cmd>Lazy<CR>'),
      button('u', '  Update Plugins', '<cmd>Lazy sync<CR>'),
      button('q', '󰅚  Quit', '<Cmd>qa<CR>'),
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

  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo1', { fg = '#311B92' }) -- Indigo
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo2', { fg = '#512DA8' }) -- Deep Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo3', { fg = '#673AB7' }) -- Deep Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo4', { fg = '#9575CD' }) -- Medium Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo5', { fg = '#B39DDB' }) -- Light Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardLogo6', { fg = '#D1C4E9' }) -- Very Light Purple
  vim.api.nvim_set_hl(0, 'NeovimDashboardInfo', { fg = '#D1C4E9' }) -- light purple

  return {
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
      val = 'Recent files',
      opts = {
        hl = 'SpecialComment',
        shrink_margin = false,
        position = 'center',
      },
    },
    { type = 'padding', val = 1 },
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
}
