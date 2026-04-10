vim.loader.enable()

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--  NOTE: You can change these options as you wish! For more options, you can see `:help option-list`
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.autoread = true
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
    vim.hl.on_yank()
  end,
})
-- Disable automatic comment insertion (Use C-u in insert mode)
-- vim.api.nvim_create_autocmd('BufEnter', {
--   desc = 'Disable automatic comment insertion',
--   group = vim.api.nvim_create_augroup('AutoComment', {}),
--   callback = function()
--     vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
--   end,
-- })

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
  vim.diagnostic.config { virtual_lines = not current }
end, {})
-- [[ Tool Commands ]]
-- G is a wrapper around git
vim.api.nvim_create_user_command('G', function(opts)
  local command = 'git ' .. opts.args
  vim.notify('[G (wrapper for git)] Executed: ' .. command)
  vim.cmd('echo system("' .. command .. '", getreg(\'"\', 1, 1))')
end, { nargs = 1 })
-- Copy the current file path to the clipboard
vim.api.nvim_create_user_command('CopyPath', function()
  local abs = vim.fn.expand '%:p'
  local root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(vim.fn.expand '%:p:h') .. ' rev-parse --show-toplevel')[1]
  local path = root and vim.startswith(abs, root) and abs:sub(#root + 2) or vim.fn.expand '%'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
-- Copy the current file to the clipboard (macOS)
vim.api.nvim_create_user_command('CopyFile', function()
  local file = vim.fn.expand('%:p')
  local script = string.format(
    'osascript -e \'tell app "Finder" to set the clipboard to (POSIX file "%s")\'',
    file
  )
  local result = vim.fn.system(script)
  vim.notify('File copied: ' .. file, vim.log.levels.INFO)
end, {})
-- Delete a mark by key
vim.api.nvim_create_user_command('Delmark', function()
  vim.ui.input({ prompt = 'Enter mark to delete: ' }, function(input)
    if input and input ~= '' then
      vim.cmd('delm ' .. input)
      vim.cmd 'redraw!'
      vim.notify('Deleted mark: ' .. input)
    end
  end)
end, { desc = 'Delete mark by key with popup input' })
-- Diff this buffer
vim.api.nvim_create_user_command('DiffThis', function()
  if vim.wo.diff then
    vim.cmd 'diffoff'
    vim.notify('Diff off', vim.log.levels.INFO)
    return
  end

  vim.cmd 'diffthis'
  vim.notify('Diff on', vim.log.levels.INFO)
end, {})

-- [[ Configure diagnostic symbols ]]
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  virtual_lines = false,
  virtual_text = {
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO },
    source = true,
    spacing = 1,
  },
  signs = {
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO },
    text = {
      [vim.diagnostic.severity.ERROR] = '', -- '',
      [vim.diagnostic.severity.WARN] = '', -- '',
      [vim.diagnostic.severity.INFO] = '', -- '',
      [vim.diagnostic.severity.HINT] = '', -- '󰌵',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    },
  },
  underline = {
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO },
  },
  float = {
    severity_sort = true,
  },
}

-- [[ Custom underline handler to set priority of underline highlights ]]
vim.diagnostic.handlers.underline = {
  show = function(namespace, bufnr, diagnostics, opts)
    local ns = vim.diagnostic.get_namespace(namespace)
    if not ns.user_data.underline_ns then
      ns.user_data.underline_ns = vim.api.nvim_create_namespace 'diagnostic/underline'
    end
    local extmark_ns = ns.user_data.underline_ns

    vim.api.nvim_buf_clear_namespace(bufnr, extmark_ns, 0, -1)

    for _, diag in ipairs(diagnostics) do
      local severity = diag.severity
      local priority = 100 + (4 - severity) * 10
      local hl_group = 'DiagnosticUnderline'
          .. ({
            [vim.diagnostic.severity.ERROR] = 'Error',
            [vim.diagnostic.severity.WARN] = 'Warn',
            [vim.diagnostic.severity.INFO] = 'Info',
            [vim.diagnostic.severity.HINT] = 'Hint',
          })[severity]
        or 'DiagnosticUnderlineError'

      if diag.tags and vim.tbl_contains(diag.tags, 1) then
        hl_group = 'DiagnosticUnnecessary'
      end

      pcall(vim.api.nvim_buf_set_extmark, bufnr, extmark_ns, diag.lnum, diag.col, {
        end_row = diag.end_lnum,
        end_col = diag.end_col,
        hl_group = hl_group,
        priority = priority,
      })
    end
  end,
  hide = function(namespace, bufnr)
    local ns = vim.diagnostic.get_namespace(namespace)
    if ns.user_data.underline_ns then
      vim.api.nvim_buf_clear_namespace(bufnr, ns.user_data.underline_ns, 0, -1)
    end
  end,
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
    { import = 'plugins.themes' },
    { import = 'plugins.ui' },
  },
  install = { colorscheme = { 'habamax' } },
  checker = {
    enabled = false,
    notify = true,
    frequency = 86400,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
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
