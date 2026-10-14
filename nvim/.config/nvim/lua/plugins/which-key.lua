-- stylua: ignore
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>?', function() require('which-key').show { global = false } end, desc = 'Help - Buffer-local keymaps' },
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
      -- Groups: one area per letter
      { '<leader><leader>', group = 'Picker',                  mode = { 'n', 'x' } },
      { '<leader>,',        group = 'Tools',                   mode = { 'n', 'x' } },
      { '<leader>b',        group = 'Buffer',                  mode = { 'n', 'x' } },
      { '<leader>bs',       group = 'Sort',                    mode = { 'n', 'x' } },
      { '<leader>c',        group = 'Code',                    mode = { 'n', 'x' } },
      { '<leader>d',        group = 'Edit',                    mode = { 'n', 'x' } },
      { '<leader>e',        group = 'Debug',                   mode = { 'n', 'x' } },
      { '<leader>g',        group = 'Git',                     mode = { 'n', 'x' } },
      { '<leader>h',        group = 'Hunk',                    mode = { 'n', 'x' } },
      { '<leader>r',        group = 'Run (tasks)',             mode = { 'n', 'x' } },
      { '<leader>s',        group = 'Surround',                mode = { 'n', 'x' } },
      { '<leader>t',        group = 'Test',                    mode = { 'n', 'x' } },
      { '<leader>u',        group = 'Toggle',                  mode = { 'n', 'x' } },
      { '<leader>ug',       group = 'Git',                     mode = { 'n', 'x' } },
      { '<leader>x',        group = 'Diagnostics / lists',     mode = { 'n', 'x' } },

      -- Normal mode
      {
        mode = 'n',
        { '<Esc>',           '<cmd>nohlsearch<CR>',                         desc = 'Search - Clear highlight' },
        { '<leader>dx',      ':.lua<CR>',                                   desc = 'Edit - Run line as Lua' },
        { '<leader>dX',      '<CMD>source %<CR>',                           desc = 'Edit - Source file' },
        { '<leader>d<CR>',   'i<CR><Esc>',                                  desc = 'Edit - Break line at cursor' },
        { '<leader>F',       'gg=G',                                        desc = 'Code - Reindent buffer' },
        -- User commands
        { '<leader>.',       '<Cmd>CopyPath<CR>',                           desc = 'File - Copy relative path' },
        { '<leader>>',       '<Cmd>CopyFullPath<CR>',                       desc = 'File - Copy absolute path' },
        { '<leader><C-.>',   '<Cmd>CopyFile<CR>',                           desc = 'File - Copy file to clipboard' },
        { '<leader>\\',      '<Cmd>DiffThis<CR>',                           desc = 'File - Toggle diff this' },
        { 'dm',              '<Cmd>Delmark<CR>',                            desc = 'Mark - Delete' },
        -- Diagnostics
        { '<leader>xf',      function() vim.diagnostic.open_float({ source = true, border = 'rounded' }) end, desc = 'Diagnostics - Float under cursor' },
        { '<leader>xL',      function() vim.diagnostic.setloclist() end,    desc = 'Diagnostics - Send to location list' },
        -- Tools
        { '<leader>,,',      '<Cmd>Lazy<CR>',                               desc = 'Tools - Lazy' },
        { '<leader>,<',      '<Cmd>Lazy update<CR>',                        desc = 'Tools - Lazy update' },
        { '<leader>,.',      '<cmd>Mason<CR>',                              desc = 'Tools - Mason' },
        { '<leader>,l',      '<cmd>checkhealth vim.lsp<CR>',                desc = 'Tools - LSP info' },
        -- Buffers
        { '<C-\\>',          '<Cmd>ene<CR>', noremap = true, silent = true, desc = 'Buffer - New' },
        { '<leader>bn',      '<Cmd>ene<CR>', noremap = true, silent = true, desc = 'Buffer - New' },
        -- Windows
        { '<S-BS>',          '<Cmd>fc<CR>', noremap = true, silent = true, desc = 'Window - Close floating window' },
      },
      {
        mode = 'x',
        { '<leader>dx', ':lua<CR>', desc = 'Edit - Run selection as Lua' },
        { '<', '<gv' },
        { '>', '>gv' },
        { 'J', ":m '>+1<CR>gv" },
        { 'K', ":m '<-2<CR>gv" },
      },
      {
        mode = { 'n', 'v' },
        { '<leader>j',    '10j',                 desc = 'Cursor - Down 10 lines' },
        { '<leader>k',    '10k',                 desc = 'Cursor - Up 10 lines' },
      },
      {
        mode = { 'n' , 'v' , 't' },
        { '<C-Right>', '3<C-w><C->>',         noremap = true, silent = true, desc = 'Window - Wider' },
        { '<C-Left>',  '3<C-w><C-<>',         noremap = true, silent = true, desc = 'Window - Narrower' },
        { '<C-Up>',    '3<C-w><C-+>',         noremap = true, silent = true, desc = 'Window - Taller' },
        { '<C-Down>',  '3<C-w><C-->',         noremap = true, silent = true, desc = 'Window - Shorter' },
        { '<C-h>',        [[<Cmd>wincmd h<CR>]], desc = 'Window - Focus left' },
        { '<C-j>',        [[<Cmd>wincmd j<CR>]], desc = 'Window - Focus down' },
        { '<C-k>',        [[<Cmd>wincmd k<CR>]], desc = 'Window - Focus up' },
        { '<C-l>',        [[<Cmd>wincmd l<CR>]], desc = 'Window - Focus right' },
      }
    }
  end,
}
