-- stylua: ignore
return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  keys = {
    { '<leader>?', function() require('which-key').show { global = false } end, desc = '[?] Buffer Local Keymaps' },
  },
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup {
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
      { '<leader>c',        group = '[C]ode',                 mode = { 'n', 'x' } },
      { '<leader>d',        group = '[D]ebug',                mode = { 'n', 'x' } },
      { '<leader>t',        group = '[T]esting',              mode = { 'n', 'x' } },
      { '<leader>b',        group = '[B]uffer',               mode = { 'n', 'x' } },
      { '<leader>l',        group = '[L] Tasks',              mode = { 'n', 'x' } },
      { '<leader>e',        group = '[E]rrors (Trouble)',     mode = { 'n', 'x' } },
      { '<leader>g',        group = '[G]it',                  mode = { 'n', 'x' } },
      { '<leader>h',        group = '[H]unk (Gitsigns)',      mode = { 'n', 'x' } },
      { '<leader>v',        group = '[V] Web',                mode = { 'n', 'x' } },
      { '<leader>s',        group = '[S]urround',             mode = { 'n', 'x' } },
      { '<leader>S',        group = 'I[S]wap',                mode = { 'n', 'x' } },
      { '<leader>z',        group = '[Z] Plugin / Settings',  mode = { 'n', 'x' } },
      { '<leader><leader>', group = '[󱁐] Telescope', mode = { 'n', 'x' } },

      -- Normal Mode
      {
        mode = 'n',
        { '<Esc>',            '<cmd>nohlsearch<CR>',                       desc = 'nohlsearch' },
        -- Window keybindings
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
        -- Buffer keybindings
        { '<leader>1',  '<Cmd>BufferGoto 1<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 1' },
        { '<leader>2',  '<Cmd>BufferGoto 2<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 2' },
        { '<leader>3',  '<Cmd>BufferGoto 3<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 3' },
        { '<leader>4',  '<Cmd>BufferGoto 4<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 4' },
        { '<leader>5',  '<Cmd>BufferGoto 5<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 5' },
        { '<leader>6',  '<Cmd>BufferGoto 6<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 6' },
        { '<leader>7',  '<Cmd>BufferGoto 7<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 7' },
        { '<leader>8',  '<Cmd>BufferGoto 8<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 8' },
        { '<leader>9',  '<Cmd>BufferGoto 9<CR>',                     noremap = true, silent = true, desc = 'Buffer Goto 9' },
        { '[b',         '<Cmd>BufferPrevious<CR>',                   noremap = true, silent = true, desc = 'Buffer Previous' },
        { ']b',         '<Cmd>BufferNext<CR>',                       noremap = true, silent = true, desc = 'Buffer Next' },
        { '[B',         '<Cmd>BufferMovePrevious<CR>',               noremap = true, silent = true, desc = 'Buffer Move Privious' },
        { ']B',         '<Cmd>BufferMoveNext<CR>',                   noremap = true, silent = true, desc = 'Buffer Move Next' },
        { '<leader>bn', '<Cmd>ene<CR>',                              noremap = true, silent = true, desc = 'Buffer New' },
        { '<leader>bd', '<Cmd>bd!<CR>',                              noremap = true, silent = true, desc = 'Buffer Close' },
        { '<leader>B',  '<Cmd>BufferPin<CR>',                        noremap = true, silent = true, desc = 'Buffer Pin' },
        { '<leader>bb', '<Cmd>BufferPick<CR>',                       noremap = true, silent = true, desc = 'Buffer Pick' },
        { '<leader>bl', '<Cmd>BufferLast<CR>',                       noremap = true, silent = true, desc = 'Buffer Last' },
        { '<leader>bo', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', noremap = true, silent = true, desc = 'Buffer Close All But Current or Pinned' },
        { '<leader>br', '<Cmd>BufferCloseBuffersRight<CR>',          noremap = true, silent = true, desc = 'Buffer Close the Buffers on the Right' },
        { '<leader>bB', '<Cmd>BufferOrderByBufferNumber<CR>',        noremap = true, silent = true, desc = 'Buffer Order by Number' },
        { '<leader>bN', '<Cmd>BufferOrderByName<CR>',                noremap = true, silent = true, desc = 'Buffer Order by Name' },
        { '<leader>bD', '<Cmd>BufferOrderByDirectory<CR>',           noremap = true, silent = true, desc = 'Buffer Order by Directory' },
        { '<leader>bL', '<Cmd>BufferOrderByLanguage<CR>',            noremap = true, silent = true, desc = 'Buffer Order by Language' },
        { '<leader>bW', '<Cmd>BufferOrderByWindowNumber<CR>',        noremap = true, silent = true, desc = 'Buffer Order by WindowNumber' },
        -- Plugin keybindings
        { '<leader>z`',      '<Cmd>Lazy<CR>',                             desc = '[`] Lazy - Open Menu' },
        { '<leader>zl',      '<cmd>Mason<CR>',                            desc = '[L] Mason - Open Menu' },
        { '<leader>z/',      '<Cmd>CopyPath<CR>',                         desc = 'Copy Path' },
      },
      {
        mode = 'i',
        { 'jk', '<Esc>l', desc = 'Exit insert mode' },
      },
      {
        mode = 'x',
        { '<', '<gv' },
        { '>', '>gv' },
      },
      {
        mode = 't',
        { '<esc>', '<C-\\><C-n>', desc = 'Exit terminal mode' },
      },
      {
        mode = { 'n', 'v' },
        { '<leader>zz', '<Cmd>set wrap!<CR>',                                                       desc = 'Toggle line wrap' },
        { '<leader>J',  'i<CR><Esc>',                                                               desc = 'Cursor - Add a line break' },
        { '<leader>w',  '<cmd>write<CR>',                                                           desc = 'Buffer - [W]rite' },
        { '<leader>F',  'gg=G',                                                                     desc = 'Buffer - Format (Indentation)' },
        { '<leader>q',  function() vim.diagnostic.open_float({source = true, border="rounded"}) end,desc = 'Quickfix - Diagnostics Window' },
        { '<leader>ed', function() vim.diagnostic.setloclist() end,                                 desc = 'Quickfix - Diagnostics List (Legacy)' },
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
  end,
}
