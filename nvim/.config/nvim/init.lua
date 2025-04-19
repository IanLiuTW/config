--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--  NOTE: You can change these options as you wish! For more options, you can see `:help option-list`
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.spell = false
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
vim.opt.listchars = { tab = '»─', multispace = ' ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = false -- Show which line your cursor is on
vim.opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.fixeol = false -- Don't automatically append an end of line at the end of files
vim.opt.spellfile = vim.fn.expand '~/.config/nvim/spell/en.utf-8.add'
vim.opt.guicursor = {
  'n:block-blinkwait0-blinkoff50-blinkon50',
  'i:ver25-blinkwait0-blinkoff50-blinkon50',
  'v:hor25-blinkwait0-blinkoff50-blinkon50',
  'c:block-blinkwait0-blinkoff50-blinkon50',
  'o:block50',
}
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:►]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ FileType Autocommands]]
local filetype_group = vim.api.nvim_create_augroup('filetype', { clear = true })
vim.api.nvim_create_autocmd({ 'bufnewfile', 'bufread' }, {
  group = filetype_group,
  pattern = '*.conf',
  command = 'set ft=hocon',
})

-- [[ Tool Autocommands ]] See `:help lua-guide-autocommands`
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

-- [[ Diagnostic Commands ]]
-- Set virtual text severity to Hint
vim.api.nvim_create_user_command('VirtualTextSeverityMinHint', function()
  vim.diagnostic.config { virtual_text = { severity = { min = vim.diagnostic.severity.HINT } } }
end, {})
-- Set virtual text severity to INFO
vim.api.nvim_create_user_command('VirtualTextSeverityMinInfo', function()
  vim.diagnostic.config { virtual_text = { severity = { min = vim.diagnostic.severity.INFO } } }
end, {})
-- Toggle virtual line
vim.api.nvim_create_user_command('VirtualLinesToggle', function()
  local current = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = not current })
end, {})
-- [[ Tool Commands ]]
-- G is a wrapper around git
vim.api.nvim_create_user_command('G', function(opts)
  local command = 'git ' .. opts.args
  vim.notify('[G wrapper for git] Executed: ' .. command)
  vim.cmd('echo system("' .. command .. '", getreg(\'"\', 1, 1))')
end, { nargs = 1 })
-- Copy the current file path to the clipboard
vim.api.nvim_create_user_command('CopyPath', function()
  local path = vim.fn.expand '%'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
-- Delete a mark by key
vim.api.nvim_create_user_command('Delmark', function()
  vim.ui.input({ prompt = 'Enter mark to delete: ' }, function(input)
    if input and input ~= '' then
      vim.cmd('delm ' .. input)
      vim.notify('Deleted mark: ' .. input)
    end
  end)
end, { desc = 'Delete mark by key with popup input' })

-- [[ Configure diagnostic symbols ]]
local symbols = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }
for name, icon in pairs(symbols) do
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
vim.diagnostic.config {
  update_in_insert = true,
  severity_sort = true,
  virtual_lines = true,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.INFO },
    source = true,
    spacing = 1,
  },
  signs = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
}

-- [[ Install `lazy.nvim` plugin manager ]] See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- [[ Configure and install plugins ]]
require('lazy').setup({
  spec = {
    { import = 'plugins' },
    { import = 'plugins.ai' },
    { import = 'plugins.tools' },
    { import = 'plugins.code' },
    { import = 'plugins.files' },
    { import = 'plugins.git' },
    { import = 'plugins.language' },
    { import = 'plugins.terminal' },
    { import = 'plugins.themes' },
    { import = 'plugins.ui' },
  },
  install = { colorscheme = { 'habamax' } },
  -- checker = {
  --   enabled = true,
  --   notify = true,
  --   frequency = 86400,
  -- },
  change_detection = {
    enabled = false,
    notify = false,
  },
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
