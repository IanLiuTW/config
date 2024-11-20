--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--  NOTE: You can change these options as you wish! For more options, you can see `:help option-list`
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.conceallevel = 0
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim. See `:help 'clipboard'`
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 200 -- Decrease mapped sequence wait time. Displays which-key popup sooner
vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = false -- Show which line your cursor is on
vim.opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.fixeol = false -- Don't automatically append an end of line at the end of files
vim.opt.spellfile = vim.fn.expand '~/.nvim-spellfile.add'
vim.opt.guicursor = {
  'n:block-blinkwait100-blinkoff500-blinkon500',
  'i:ver25-blinkwait100-blinkoff500-blinkon500',
  'v:hor25-blinkwait100-blinkoff500-blinkon500',
  'c:block-blinkwait100-blinkoff500-blinkon500',
}

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Basic Autocommands ]] See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Disable automatic comment insertion
vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Disable automatic comment insertion',
  group = vim.api.nvim_create_augroup('AutoComment', {}),
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

vim.api.nvim_create_user_command('CopyPath', function()
  local path = vim.fn.expand '%'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- [[ Install `lazy.nvim` plugin manager ]] See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure diagnostic symbols ]]
local symbols = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }
for name, icon in pairs(symbols) do
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
vim.diagnostic.config {
  update_in_insert = true,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.INFO },
    source = true,
  },
  signs = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
}

-- [[ Custom commands - G is a wrapper around git ]]
vim.api.nvim_create_user_command('G', function(opts)
  local command = 'git ' .. opts.args
  print('[G wrapper for git] Executed: ' .. command)
  vim.cmd('echo system("' .. command .. '", getreg(\'"\', 1, 1))')
end, { nargs = 1 })

-- [[ Configure and install plugins ]]
require('lazy').setup({
  -- Plugins can also be configured to run Lua code when they are loaded.
  -- Events can be normal autocommands events (`:help autocmd-events`).
  -- Because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded: config = function() ... end
  { import = 'plugins' },
  { import = 'plugins.ai' },
  { import = 'plugins.code' },
  { import = 'plugins.debug' },
  { import = 'plugins.file_system' },
  { import = 'plugins.git' },
  { import = 'plugins.http' },
  { import = 'plugins.language' },
  { import = 'plugins.remote' },
  { import = 'plugins.shell' },
  { import = 'plugins.task' },
  { import = 'plugins.terminal' },
  { import = 'plugins.testing' },
  { import = 'plugins.themes' },
  { import = 'plugins.ui' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
