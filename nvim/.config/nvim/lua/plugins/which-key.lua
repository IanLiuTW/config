-- stylua: ignore
return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  dependencies = {
    'tpope/vim-unimpaired',
    "afreakk/unimpaired-which-key.nvim"
  },
  keys = {
    { '<leader>?', function() require('which-key').show { global = false } end, desc = '[?] Buffer Local Keymaps' },
  },
  config = function()
    local wk = require('which-key')
    wk.setup {
      win = {
        width = { min = 40, max = 200 },
        height = { min = 4, max = 0.99 },
        padding = { 0, 1 },
        col = -1,
        row = -1,
        border = 'rounded',
        title = true,
        title_pos = 'left',
      },
      layout = {
        width = { min = 100, max = 120 },
      },
      sort = { 'order', 'mod', 'desc' },
    }
    require('which-key').add {
      -- Which-key groupings
      { '<leader>c',        group = '[C]hanges (Gitsigns)',   mode = { 'n', 'x' } },
      { '<leader>d',        group = '[D]o',                   mode = { 'n', 'x' } },
      { '<leader>b',        group = '[B]uffer',               mode = { 'n', 'x' } },
      { '<leader>g',        group = '[G]it',                  mode = { 'n', 'x' } },
      { '<leader>h',        group = '[H]arpoon',              mode = { 'n', 'x' } },
      { '<leader>s',        group = '[S]urround',             mode = { 'n', 'x' } },
      { '<leader>r',        group = '[R]un Tasks',            mode = { 'n', 'x' } },
      { '<leader>t',        group = '[T]esting',              mode = { 'n', 'x' } },
      { '<leader>y',        group = '[Y] Debug',              mode = { 'n', 'x' } },
      { '<leader>`',        group = '[`] Trouble',            mode = { 'n', 'x' } },
      { '<leader>,',        group = '[,] Settings / Sessions',mode = { 'n', 'x' } },
      { '<leader><leader>', group = '[󱁐] Telescope',          mode = { 'n', 'x' } },
      { '<leader>e',        group = '(Empty)',                mode = { 'n', 'x' } },
      { '<leader>n',        group = '(Empty)',                mode = { 'n', 'x' } },
      { '<leader>l',        group = '(Empty)',                mode = { 'n', 'x' } },

      -- Normal Mode
      {
        mode = 'n',
        { '<Esc>',            '<cmd>nohlsearch<CR>',                      desc = 'nohlsearch' },
        {'<leader>dx',        ':.lua<CR>',                                desc = 'Execute - Current Line with Lua'},
        {'<leader>dX',        '<CMD>source %<CR>',                        desc = 'Execute - Source Current File'},
        -- Autocommands keybindings
        { '<leader>d/',      '<Cmd>CopyPath<CR>',                         desc = 'User Command - Copy Path' },
        { 'dm',      '<Cmd>Delmark<CR>',                         desc = 'User Command - Delete Mark' },
        -- Plugin keybindings
        { '<leader>,,',      '<Cmd>Lazy<CR>',                             desc = 'Lazy - Open Menu' },
        { '<leader>,u',      '<Cmd>Lazy update<CR>',                      desc = 'Lazy - Update Plugins' },
        { '<leader>,m',      '<cmd>Mason<CR>',                            desc = 'Mason - Open Menu' },
        -- Buffer keybindings
        { '<leader><CR>',   '<Cmd>ene<CR>', noremap = true, silent = true, desc = 'Buffer - New' },
        { '<leader>bn',     '<Cmd>ene<CR>', noremap = true, silent = true, desc = 'Buffer - New' },
        { '<leader>bd',     '<Cmd>bd<CR>',  noremap = true, silent = true, desc = 'Buffer - Close' },
        { '<leader>bD',     '<Cmd>bd!<CR>', noremap = true, silent = true, desc = 'Buffer - Force Close' },
        -- Window keybindings
        { '<S-BS>',     '<Cmd>fc<CR>', noremap = true, silent = true, desc = 'Window - Close Floating Window' },
        -- { '',     '<Cmd>sp<CR>', noremap = true, silent = true, desc = 'Pane Horizontal Split' },
        -- { '',     '<Cmd>vs<CR>', noremap = true, silent = true, desc = 'Pane Vertical Split' },
        -- { '',     '<C-w><C-o>',  noremap = true, silent = true, desc = 'Pane close other panes' },
        -- { '',     '<C-w><C-T>',  noremap = true, silent = true, desc = 'Pane into a new Tab' },
        -- { '',     '<C-w><C-w>',  noremap = true, silent = true, desc = 'Pane switch windows' },
        -- { '',     '<C-w><C-x>',  noremap = true, silent = true, desc = 'Pane swap windows' },
        -- { '',     '<C-w><C-q>',  noremap = true, silent = true, desc = 'Pane quit' },
        -- { '',     '<C-w><C-_>',  noremap = true, silent = true, desc = 'Pane max width' },
        -- { '',     '<C-w><C-|>',  noremap = true, silent = true, desc = 'Pane max height' },
        -- { '',     '<C-w><C-=>',  noremap = true, silent = true, desc = 'Pane reset size' },
      },
      {
        mode = 'i',
        { 'jk', '<Esc>l', desc = 'Exit insert mode' },
      },
      {
        mode = 'x',
        {'<leader>dx', ':lua<CR>', desc = 'Execute - Selected with Lua'},
        { '<', '<gv' },
        { '>', '>gv' },
      },
      {
        mode = 't',
        { '<esc>', '<C-\\><C-n>', desc = 'Exit terminal mode' },
      },
      {
        mode = { 'n', 'v' },
        -- { '<leader>z', '<Cmd>set wrap!<CR>',                                                       desc = 'Toggle line wrap' },
        { '<leader>J',  'i<CR><Esc>',                                                               desc = 'Cursor - Add a line break' },
        { '<leader>w',  '<cmd>write<CR>',                                                           desc = 'Buffer - [W]rite' },
        { '<leader>F',  'gg=G',                                                                     desc = 'Buffer - Format (Indentation)' },
        { '<leader>q',  function() vim.diagnostic.open_float({source = true, border="rounded"}) end,desc = 'Quickfix - Diagnostics Window' },
        { '<leader>`Q', function() vim.diagnostic.setloclist() end,                                 desc = 'Quickfix - Diagnostics List (Legacy)' },
      },
      {
        mode = { 'n' , 'v' , 't' },
        { '<leader>p',    '"0p',                 desc = 'Cursor - [P]aste copied text' },
        { '<leader>j',    '10j',                 desc = 'Cursor - [j] * 10' },
        { '<leader>k',    '10k',                 desc = 'Cursot - [k] * 10' },
        { '<C-W><Right>', '3<C-w><C->>',         noremap = true, silent = true, desc = 'Pane increase width' },
        { '<C-W><Left>',  '3<C-w><C-<>',         noremap = true, silent = true, desc = 'Pane decrease width' },
        { '<C-W><Up>',    '2<C-w><C-+>',         noremap = true, silent = true, desc = 'Pane increase height' },
        { '<C-W><Down>',  '2<C-w><C-->',         noremap = true, silent = true, desc = 'Pane decrease height' },
        { '<C-h>',        [[<Cmd>wincmd h<CR>]], desc = 'Move focus to the left window' },
        { '<C-j>',        [[<Cmd>wincmd j<CR>]], desc = 'Move focus to the lower window' },
        { '<C-k>',        [[<Cmd>wincmd k<CR>]], desc = 'Move focus to the upper window' },
        { '<C-l>',        [[<Cmd>wincmd l<CR>]], desc = 'Move focus to the right window' },
      }
    }
    wk.add(require("unimpaired-which-key"))
  end,
}
