-- stylua: ignore
return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  lazy = false,
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
      { '<leader>b',        group = '[B]uffer',               mode = { 'n', 'x' } },
      { '<leader>c',        group = '[C]hanges (Gitsigns)',   mode = { 'n', 'x' } },
      { '<leader>d',        group = '[D]o',                   mode = { 'n', 'x' } },
      { '<leader>e',        group = '[E] Debug',              mode = { 'n', 'x' } },
      { '<leader>w',        group = '[W] Trouble',            mode = { 'n', 'x' } },
      { '<leader>g',        group = '[G]it',                  mode = { 'n', 'x' } },
      { '<leader>s',        group = '[S]urround',             mode = { 'n', 'x' } },
      { '<leader>r',        group = '[R]un',                  mode = { 'n', 'x' } },
      { '<leader>t',        group = '[T]esting',              mode = { 'n', 'x' } },
      { '<leader>y',        group = '[Y] Tasks',              mode = { 'n', 'x' } },
      { '<leader>,',        group = '[,] Settings / Sessions',mode = { 'n', 'x' } },
      { '<leader><leader>', group = '[󱁐] Picker',             mode = { 'n', 'x' } },
      { '<leader>;',        group = 'AI',                     mode = { 'n', 'x' } },
      { '<leader>l',        group = '(Empty)',                mode = { 'n', 'x' } },
      { '<leader>h',        group = '(Empty)',                mode = { 'n', 'x' } },
      { '<leader>n',        group = '(Empty)',                mode = { 'n', 'x' } },
      { '<leader>,v',       group = 'Virtual Text Min Severity',       mode = { 'n', 'x' } },

      -- Normal Mode
      {
        mode = 'n',
        { '<Esc>',           '<cmd>nohlsearch<CR>',                         desc = 'nohlsearch' },
        {'<leader>dx',       ':.lua<CR>',                                   desc = 'Execute - Current Line with Lua'},
        {'<leader>dX',       '<CMD>source %<CR>',                           desc = 'Execute - Source Current File'},
        -- User Commands keybindings
        { '<leader>d/',      '<Cmd>CopyPath<CR>',                           desc = 'User Command - Copy Path' },
        { '<leader>d\\',     '<Cmd>DiffThis<CR>',                           desc = 'User Command - Diff This' },
        { 'dm',              '<Cmd>Delmark<CR>',                            desc = 'User Command - Delete Mark' },
        { '<leader>,vi',     '<Cmd>VirtualTextSeverityMinInfo<CR>',         desc = 'User Command - Virtual Text Min Severity: Info' },
        { '<leader>,vh',     '<Cmd>VirtualTextSeverityMinHint<CR>',         desc = 'User Command - Virtual Text Min Severity: Hint' },
        { '<leader>x',       '<Cmd>VirtualLinesToggle<CR>',                 desc = 'User Command - Virtual Lines Toggle' },
        -- Plugin keybindings
        { '<leader>,,',      '<Cmd>Lazy<CR>',                               desc = 'Lazy - Open Menu' },
        { '<leader>,<',      '<Cmd>Lazy update<CR>',                        desc = 'Lazy - Update Plugins' },
        { '<leader>,.',      '<cmd>Mason<CR>',                              desc = 'Mason - Open Menu' },
        { '<leader>,/',      '<cmd>MCPHub<CR>',                             desc = 'MCPHub - Open Menu' },
        -- Buffer keybindings
        { '<C-\\>',          '<Cmd>ene<CR>', noremap = true, silent = true, desc = 'Buffer - New' },
        { '<leader>bn',      '<Cmd>ene<CR>', noremap = true, silent = true, desc = 'Buffer - New' },
        { '<leader>bd',      '<Cmd>bd<CR>',  noremap = true, silent = true, desc = 'Buffer - Close' },
        { '<leader>bD',      '<Cmd>bd!<CR>', noremap = true, silent = true, desc = 'Buffer - Force Close' },
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
      },
      {
        mode = 'x',
        {'<leader>dx', ':lua<CR>', desc = 'Execute - Selected with Lua'},
        { '<', '<gv' },
        { '>', '>gv' },
        { 'J', ":m '>+1<CR>gv" },
        { 'K', ":m '<-2<CR>gv" },
      },
      {
        mode = 't',
        -- { '<C-q>', '<C-\\><C-n>', desc = 'Exit terminal mode' },
      },
      {
        mode = { 'n', 'v' },
        { '<leader>J',  'i<CR><Esc>',                                                               desc = 'Cursor - Add a line break' },
        { '<leader>F',  'gg=G',                                                                     desc = 'Buffer - Format (Indentation)' },
        { '<leader>q',  function() vim.diagnostic.open_float({source = true, border="rounded"}) end,desc = 'Quickfix - Diagnostics Window' },
        { '<leader>wQ', function() vim.diagnostic.setloclist() end,                                 desc = 'Quickfix - Diagnostics List (Legacy)' },
      },
      {
        mode = { 'n' , 'v' , 't' },
        -- { '<leader>p',    '"0p',                 desc = 'Cursor - [P]aste copied text' },  -- Use mini-operators: `gp`
        { '<leader>j',    '10j',                 desc = 'Cursor - [j] * 10' },
        { '<leader>k',    '10k',                 desc = 'Cursot - [k] * 10' },
        { '<C-Right>', '3<C-w><C->>',         noremap = true, silent = true, desc = 'Pane increase width' },
        { '<C-Left>',  '3<C-w><C-<>',         noremap = true, silent = true, desc = 'Pane decrease width' },
        { '<C-Up>',    '3<C-w><C-+>',         noremap = true, silent = true, desc = 'Pane increase height' },
        { '<C-Down>',  '3<C-w><C-->',         noremap = true, silent = true, desc = 'Pane decrease height' },
        { '<C-h>',        [[<Cmd>wincmd h<CR>]], desc = 'Move focus to the left window' },
        { '<C-j>',        [[<Cmd>wincmd j<CR>]], desc = 'Move focus to the lower window' },
        { '<C-k>',        [[<Cmd>wincmd k<CR>]], desc = 'Move focus to the upper window' },
        { '<C-l>',        [[<Cmd>wincmd l<CR>]], desc = 'Move focus to the right window' },
      }
    }
  end,
}
