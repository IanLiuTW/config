vim.loader.enable()

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
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 200 -- Low so which-key opens sooner
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '»─', multispace = ' ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = false
vim.opt.scrolloff = 5
vim.opt.fixeol = false -- Keep files without a final newline as they are
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions' -- localoptions lets auto-session restore filetype and highlighting
vim.opt.spellfile = vim.fn.expand '~/.config/nvim/spell/en.utf-8.add'
vim.opt.guicursor = {
  'n:block-blinkwait0-blinkoff50-blinkon50',
  'i:ver25-blinkwait0-blinkoff50-blinkon50',
  'v:hor25-blinkwait0-blinkoff50-blinkon50',
  'c:block-blinkwait0-blinkoff50-blinkon50',
  'o:block50',
}
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:▶]]

-- Set before lazy.nvim loads plugins, so their maps use this leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Filetypes ]]
local filetype_group = vim.api.nvim_create_augroup('filetype', { clear = true })
vim.api.nvim_create_autocmd({ 'bufnewfile', 'bufread' }, {
  group = filetype_group,
  pattern = '*.conf',
  command = 'set ft=hocon',
})

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Diagnostic commands ]]
vim.api.nvim_create_user_command('VirtualTextSeverityMinHint', function()
  vim.diagnostic.config { virtual_text = { severity = { min = vim.diagnostic.severity.HINT } } }
end, {})
vim.api.nvim_create_user_command('VirtualTextSeverityMinInfo', function()
  vim.diagnostic.config { virtual_text = { severity = { min = vim.diagnostic.severity.INFO } } }
end, {})
vim.api.nvim_create_user_command('VirtualLinesToggle', function()
  local current = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config { virtual_lines = not current }
end, {})
-- [[ Tool commands ]]
-- :G runs git with the unnamed register as stdin
vim.api.nvim_create_user_command('G', function(opts)
  local command = 'git ' .. opts.args
  vim.notify('[G (wrapper for git)] Executed: ' .. command)
  print(vim.fn.system(command, vim.fn.getreg('"', 1, true)))
end, { nargs = 1 })
-- Copy the file path relative to the git root
vim.api.nvim_create_user_command('CopyPath', function()
  -- Resolve symlinks (e.g. ~/.config/nvim -> ~/config/...) so the path matches git's real toplevel
  local abs = vim.uv.fs_realpath(vim.fn.expand '%:p') or vim.fn.expand '%:p'
  local root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(vim.fn.expand '%:p:h') .. ' rev-parse --show-toplevel')[1]
  local path = root and vim.startswith(abs, root) and abs:sub(#root + 2) or vim.fn.expand '%'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
vim.api.nvim_create_user_command('CopyFullPath', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
-- Copy the file itself, not its path, to the macOS clipboard
vim.api.nvim_create_user_command('CopyFile', function()
  local file = vim.fn.expand('%:p')
  local script = string.format(
    'osascript -e \'tell app "Finder" to set the clipboard to (POSIX file "%s")\'',
    file
  )
  local result = vim.fn.system(script)
  if vim.v.shell_error ~= 0 then
    vim.notify('CopyFile failed: ' .. result, vim.log.levels.ERROR)
    return
  end
  vim.notify('File copied: ' .. file, vim.log.levels.INFO)
end, {})
vim.api.nvim_create_user_command('Delmark', function()
  vim.ui.input({ prompt = 'Enter mark to delete: ' }, function(input)
    if input and input ~= '' then
      vim.cmd('delm ' .. input)
      vim.cmd 'redraw!'
      vim.notify('Deleted mark: ' .. input)
    end
  end)
end, { desc = 'Delete mark by key with popup input' })
vim.api.nvim_create_user_command('DiffThis', function()
  if vim.wo.diff then
    vim.cmd 'diffoff'
    vim.notify('Diff off', vim.log.levels.INFO)
    return
  end

  vim.cmd 'diffthis'
  vim.notify('Diff on', vim.log.levels.INFO)
end, {})

-- [[ Diagnostics ]]
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
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
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

-- [[ Underline handler ]]
-- Replaces the built-in handler so higher severities get higher extmark priority and draw on top
vim.diagnostic.handlers.underline = {
  show = function(namespace, bufnr, diagnostics, opts)
    local ns = vim.diagnostic.get_namespace(namespace)
    if not ns.user_data.underline_ns then
      ns.user_data.underline_ns = vim.api.nvim_create_namespace('diagnostic/underline/' .. ns.name)
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

-- [[ Install lazy.nvim ]]
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
-- [[ Plugins ]]
require('lazy').setup({
  spec = {
    { import = 'plugins' },
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
  ui = {
    border = 'rounded',
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
-- vim: ts=2 sts=2 sw=2 et
