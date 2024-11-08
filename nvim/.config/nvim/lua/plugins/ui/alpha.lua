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
  vim.api.nvim_set_hl(0, 'NeovimDashboardQuote', { fg = '#808080' })

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
    local datetime = os.date ' %Y-%m-%d'
    local platform = vim.fn.has 'win32' == 1 and '' or ''
    return string.format('󰂖 %d Plugins       v%d.%d.%d @ %s      %s', plugins, v.major, v.minor, v.patch, platform, datetime)
  end

  --stylua: ignore
  ---@return table
  lazycache.menu = function()
    return {
      button('t',       '  New file',                    '<cmd>ene<CR>'),
      button('-',       '  File Browser (Oil)'),
      button('\\',      '  File Browser (Neo-Tree)'),
      button('.',       '  Load Last Session',           '<cmd>NeovimProjectLoadRecent<CR>'),
      button('p',       '󰑓  Load Project (History)',      '<cmd>Telescope neovim-project history<CR>'),
      button('P',       '󱦞  Load Project (Discovery)',    '<cmd>Telescope neovim-project discover<CR>'),
      button('󱁐  󱁐  f', '  Search Files'),
      button('󱁐  󱁐  .', '  Search Recent Files'),
      button('󱁐  󱁐  g', '󰊄  Search with Live Grep'),
      button('󱁐  󱁐  ,', '  Search Neovim Config'),
      button('󱁐  z  L', '󰂖  Show Lazy Plugin'),
      button('󱁐  z  M', '󰀬  Show Mason Plugin'),
      button('u',       '  Quick Update Plugins',        '<cmd>Lazy sync<CR>'),
      button('q',       '󰅚  Quit',                        '<cmd>qa<CR>'),
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
      val = '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      opts = { hl = 'NeovimDashboardLogo1', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      opts = { hl = 'NeovimDashboardLogo2', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      opts = { hl = 'NeovimDashboardLogo3', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      opts = { hl = 'NeovimDashboardLogo4', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      opts = { hl = 'NeovimDashboardLogo5', shrink_margin = false, position = 'center' },
    },
    {
      type = 'text',
      val = '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
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
    { type = 'padding', val = 1 },
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
      opts = { hl = 'NeovimDashboardQuote', position = 'center' },
    },
    { type = 'padding', val = 2 },
  }
end

return {
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
}
