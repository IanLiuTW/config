--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.opt.termguicolors = true

-- [[ Setting options ]] See `:help vim.opt`
-- NOTE: You can change these options as you wish! For more options, you can see `:help option-list`
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim. See `:help 'clipboard'`
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time. Displays which-key popup sooner
vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

-- [[ Basic Keymaps ]] See `:help vim.keymap.set()`
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>J', 'i<CR><Esc>', { desc = 'Add a line break' })
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = '[W]rite buffer' })
vim.keymap.set('n', '<leader>zq', '<Cmd>q<CR>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>zQ', '<Cmd>qa<CR>', { desc = '[Q]uit All' })
vim.keymap.set('n', '<leader>ck', '<Cmd>m -2<CR>', { desc = 'Move Line Up' })
vim.keymap.set('n', '<leader>cj', '<Cmd>m +1<CR>', { desc = 'Move Line Down' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[Q]uickfix diagnostic list' })
vim.keymap.set('n', '<A-z>', '<Cmd>set wrap!<CR>', { desc = 'Toggle line wrap' })
vim.keymap.set('n', '<leader><leader>', 'gcc', { desc = '[ ] Toggle Comment', remap = true })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<A-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<A-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<A-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<A-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Pane keybindings
vim.keymap.set('n', '<A-s>', '<Cmd>sp<CR>', { noremap = true, silent = true, desc = 'Pane Horizontal Split' })
vim.keymap.set('n', '<A-v>', '<Cmd>vs<CR>', { noremap = true, silent = true, desc = 'Pane Vertical Split' })
vim.keymap.set('n', '<A-Right>', '<C-w><C->>', { noremap = true, silent = true, desc = 'Pane increase width' })
vim.keymap.set('n', '<A-Left>', '<C-w><C-<>', { noremap = true, silent = true, desc = 'Pane decrease width' })
vim.keymap.set('n', '<A-Up>', '<C-w><C-+>', { noremap = true, silent = true, desc = 'Pane increase height' })
vim.keymap.set('n', '<A-Down>', '<C-w><C-->', { noremap = true, silent = true, desc = 'Pane decrease height' })
vim.keymap.set('n', '<A-=>', '<C-w><C-=>', { noremap = true, silent = true, desc = 'Pane reset size' })
vim.keymap.set('n', '<A-|>', '<C-w><C-|>', { noremap = true, silent = true, desc = 'Pane max height' })
vim.keymap.set('n', '<A-_>', '<C-w><C-_>', { noremap = true, silent = true, desc = 'Pane max width' })
vim.keymap.set('n', '<A-bs>', '<C-w><C-o>', { noremap = true, silent = true, desc = 'Pane close other panes' })
vim.keymap.set('n', '<A-T>', '<C-w><C-T>', { noremap = true, silent = true, desc = 'Pane into a new Tab' })
vim.keymap.set('n', '<A-Tab>', '<C-w><C-w>', { noremap = true, silent = true, desc = 'Pane switch windows' })
vim.keymap.set('n', '<A-x>', '<C-w><C-x>', { noremap = true, silent = true, desc = 'Pane swap windows' })
vim.keymap.set('n', '<A-q>', '<C-w><C-q>', { noremap = true, silent = true, desc = 'Pane quit' })
-- Tab keybindings
vim.keymap.set('n', '<A-t>', '<Cmd>ene<CR>', { noremap = true, silent = true, desc = 'Buffer New' })
vim.keymap.set('n', '<A-e>', '<Cmd>BufferPick<CR>', { noremap = true, silent = true, desc = 'Buffer Pick' })
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = 'Buffer Previous' })
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = 'Buffer Next' })
vim.keymap.set('n', '<A-p>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true, desc = 'Buffer Move Privious' })
vim.keymap.set('n', '<A-n>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true, desc = 'Buffer Move Next' })
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 1' })
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 2' })
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 3' })
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 4' })
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 5' })
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 6' })
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 7' })
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 8' })
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = 'Buffer Goto 9' })
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true, desc = 'Buffer Last' })
vim.keymap.set('n', '<A-w>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = 'Buffer Close' })
vim.keymap.set('n', '<A-o>', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', { noremap = true, silent = true, desc = 'Buffer Close' })
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPin<CR>', { noremap = true, silent = true, desc = 'Pin Buffer' })
vim.keymap.set('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { noremap = true, silent = true, desc = 'Order Buffer by Number' })
vim.keymap.set('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', { noremap = true, silent = true, desc = 'Order Buffer by Name' })
vim.keymap.set('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', { noremap = true, silent = true, desc = 'Order Buffer by Directory' })
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', { noremap = true, silent = true, desc = 'Order Buffer by Language' })
vim.keymap.set('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { noremap = true, silent = true, desc = 'Order Buffer by WindowNumber' })

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<leader>p', '"0p', { desc = 'Paste copied text' })
vim.keymap.set('x', '<leader><leader>', 'gc', { desc = '[ ] Toggle Comment', remap = true })

vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<A-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set('t', '<A-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set('t', '<A-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set('t', '<A-l>', [[<Cmd>wincmd l<CR>]])

vim.keymap.set({'n', 'x'}, '<leader>j', '10j', { desc = '[J] * 10' })
vim.keymap.set({'n', 'x'}, '<leader>k', '10k', { desc = '[K] * 10' })

-- [[ Basic Autocommands ]] See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
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
vim.keymap.set('n', '<leader>pL', '<Cmd>Lazy<CR>', { desc = '[P]lugin [L]azy' })

local symbols = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }
for name, icon in pairs(symbols) do
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run `:Lazy`
--  You can press `?` in this menu for help. Use `:q` to close the window
--  To update plugins you can run `:Lazy update`
--
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following keys can be used to configure plugin behavior/loading/etc.
  -- Use `opts = {}` to force a plugin to be loaded.

  -- OTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]erminal' },
        { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>o', group = '[O]oversee Tasks' },
        { '<leader>r', group = 'Su[R]round' },
        { '<leader>p', group = '[P]lugin/[P]orject/Session' },
        { '<leader>z', group = 'Extra[Z]', mode = { 'n', 'x' } },
      }
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = '<leader>ra', -- Add surrounding in Normal and Visual modes
          delete = '<leader>rd', -- Delete surrounding
          find = '<leader>rf', -- Find surrounding (to the right)
          find_left = '<leader>rF', -- Find surrounding (to the left)
          highlight = '<leader>rh', -- Highlight surrounding
          replace = '<leader>rs', -- Replace surrounding
          update_n_lines = '<leader>rn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      }

      -- Show minimap of the current buffer
      local map = require 'mini.map'
      map.setup {
        integrations = {
          map.gen_integration.gitsigns(),
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic(),
        },
      }
      vim.keymap.set('n', '<Leader>zm', MiniMap.toggle, { desc = '[M]inimap Toggle' })
      vim.keymap.set('n', '<Leader>zM', MiniMap.toggle_focus, { desc = '[M]inimap Toggle Focus' })

      -- -- Simple and easy statusline.
      -- --  You could remove this setup call if you don't like it,
      -- --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }
      --
      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- require('mini.files').setup {
      --   windows = {
      --     preview = true,
      --     width_preview = 80,
      --   },
      -- }
      -- vim.keymap.set('n', '<leader>.', '<cmd>:lua MiniFiles.open(nil, false)<CR>', { desc = '[.] Open Mini Files' })
      -- -- ... and there is more!
      -- --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.
  { import = 'plugins.ai' },
  { import = 'plugins.code' },
  { import = 'plugins.debug' },
  { import = 'plugins.file_system' },
  { import = 'plugins.git' },
  { import = 'plugins.keymaps' },
  { import = 'plugins.language' },
  { import = 'plugins.session' },
  { import = 'plugins.task' },
  { import = 'plugins.terminal' },
  { import = 'plugins.themes' },
  { import = 'plugins.ui' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
