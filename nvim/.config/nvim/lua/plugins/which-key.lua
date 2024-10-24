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
        width = { min = 30, max = 120 },
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
      { '<leader>c', group = '[C]ode',                      mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ebug',                     mode = { 'n', 'x' } },
      { '<leader>t', group = '[T]esting',                   mode = { 'n', 'x' } },
      { '<leader>b', group = '[B]uffer',                    mode = { 'n', 'x' } },
      { '<leader>l', group = '[L] Tasks',                   mode = { 'n', 'x' } },
      { '<leader>s', group = '[S]earch',                    mode = { 'n', 'x' } },
      { '<leader>g', group = '[G]it',                       mode = { 'n', 'x' } },
      { '<leader>z', group = '[Z] Plugin / Settings',        mode = { 'n', 'x' } },
      -- Normal Mode
      {
        mode = 'n',
        -- UI keybindings
        { '<Esc>',            '<cmd>nohlsearch<CR>',                       desc = 'nohlsearch' },
        -- Code keybindings
        { '<leader>J',        'i<CR><Esc>',                                desc = 'Cursor - Add a line break' },
        { '<leader>ck',       '<Cmd>m -2<CR>',                             desc = 'Move Line Up' },
        { '<leader>cj',       '<Cmd>m +1<CR>',                             desc = 'Move Line Down' },
        { '<leader>zz',       '<Cmd>set wrap!<CR>',                        desc = 'Toggle line wrap' },
        { '<leader><leader>', 'gcc',                                       desc = '[ ] Toggle Comment', remap = true },
        -- Pane keybindings
        { '<A-h>',            '<C-w><C-h>',                                desc = 'Move focus to the left window' },
        { '<A-l>',            '<C-w><C-l>',                                desc = 'Move focus to the right window' },
        { '<A-j>',            '<C-w><C-j>',                                desc = 'Move focus to the lower window' },
        { '<A-k>',            '<C-w><C-k>',                                desc = 'Move focus to the upper window' },
        { '<A-s>',            '<Cmd>sp<CR>',                               noremap = true,              silent = true,  desc = 'Pane Horizontal Split' },
        { '<A-v>',            '<Cmd>vs<CR>',                               noremap = true,              silent = true,  desc = 'Pane Vertical Split' },
        { '<A-x>',            '<C-w><C-o>',                                noremap = true,              silent = true,  desc = 'Pane close other panes' },
        { '<A-g>',            '<C-w><C-T>',                                noremap = true,              silent = true,  desc = 'Pane into a new Tab' },
        { '<A-f>',            '<C-w><C-w>',                                noremap = true,              silent = true,  desc = 'Pane switch windows' },
        { '<A-d>',            '<C-w><C-x>',                                noremap = true,              silent = true,  desc = 'Pane swap windows' },
        { '<A-q>',            '<C-w><C-q>',                                noremap = true,              silent = true,  desc = 'Pane quit' },
        { '<A-Right>',        '<C-w><C->>',                                noremap = true,              silent = true,  desc = 'Pane increase width' },
        { '<A-Left>',         '<C-w><C-<>',                                noremap = true,              silent = true,  desc = 'Pane decrease width' },
        { '<A-Up>',           '<C-w><C-+>',                                noremap = true,              silent = true,  desc = 'Pane increase height' },
        { '<A-Down>',         '<C-w><C-->',                                noremap = true,              silent = true,  desc = 'Pane decrease height' },
        -- {'<A-->',          '<C-w><C-_>',                                noremap = true,              silent = true,  desc = 'Pane max width' },
        -- {'<A-=>',          '<C-w><C-|>',                                noremap = true,              silent = true,  desc = 'Pane max height' },
        -- {'<A-0>',          '<C-w><C-=>',                                noremap = true,              silent = true,  desc = 'Pane reset size' },
        -- Tab keybindings
        { '<A-t>',            '<Cmd>ene<CR>',                              noremap = true,              silent = true,  desc = 'Buffer New' },
        { '<A-e>',            '<Cmd>BufferPick<CR>',                       noremap = true,              silent = true,  desc = 'Buffer Pick' },
        { '<A-,>',            '<Cmd>BufferPrevious<CR>',                   noremap = true,              silent = true,  desc = 'Buffer Previous' },
        { '<A-.>',            '<Cmd>BufferNext<CR>',                       noremap = true,              silent = true,  desc = 'Buffer Next' },
        { '<A-p>',            '<Cmd>BufferMovePrevious<CR>',               noremap = true,              silent = true,  desc = 'Buffer Move Privious' },
        { '<A-n>',            '<Cmd>BufferMoveNext<CR>',                   noremap = true,              silent = true,  desc = 'Buffer Move Next' },
        { '<A-1>',            '<Cmd>BufferGoto 1<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 1' },
        { '<A-2>',            '<Cmd>BufferGoto 2<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 2' },
        { '<A-3>',            '<Cmd>BufferGoto 3<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 3' },
        { '<A-4>',            '<Cmd>BufferGoto 4<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 4' },
        { '<A-5>',            '<Cmd>BufferGoto 5<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 5' },
        { '<A-6>',            '<Cmd>BufferGoto 6<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 6' },
        { '<A-7>',            '<Cmd>BufferGoto 7<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 7' },
        { '<A-8>',            '<Cmd>BufferGoto 8<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 8' },
        { '<A-9>',            '<Cmd>BufferGoto 9<CR>',                     noremap = true,              silent = true,  desc = 'Buffer Goto 9' },
        { '<A-`>',            '<Cmd>BufferLast<CR>',                       noremap = true,              silent = true,  desc = 'Buffer Last' },
        { '<A-w>',            '<Cmd>BufferClose<CR>',                      noremap = true,              silent = true,  desc = 'Buffer Close' },
        { '<A-o>',            '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', noremap = true,              silent = true,  desc = 'Buffer Close All But Current or Pinned' },
        { '<A-y>',            '<Cmd>BufferCloseBuffersRight<CR>',          noremap = true,              silent = true,  desc = 'Buffer Close the Buffers on the Right' },
        { '<leader>bp',       '<Cmd>BufferPin<CR>',                        noremap = true,              silent = true,  desc = 'Pin Buffer' },
        { '<leader>bb',       '<Cmd>BufferOrderByBufferNumber<CR>',        noremap = true,              silent = true,  desc = 'Order Buffer by Number' },
        { '<leader>bn',       '<Cmd>BufferOrderByName<CR>',                noremap = true,              silent = true,  desc = 'Order Buffer by Name' },
        { '<leader>bd',       '<Cmd>BufferOrderByDirectory<CR>',           noremap = true,              silent = true,  desc = 'Order Buffer by Directory' },
        { '<leader>bl',       '<Cmd>BufferOrderByLanguage<CR>',            noremap = true,              silent = true,  desc = 'Order Buffer by Language' },
        { '<leader>bw',       '<Cmd>BufferOrderByWindowNumber<CR>',        noremap = true,              silent = true,  desc = 'Order Buffer by WindowNumber' },
        -- Plugin keybindings
        { '<leader>zL',      '<Cmd>Lazy<CR>',                             desc = '[L]azy - Open Menu' },
        { '<leader>zM',      '<cmd>Mason<CR>',                            desc = '[M]ason - Open Menu' },
        -- User commands bindings
        { '<leader>z/',      '<Cmd>CopyPath<CR>',                         desc = '[C]opy [P]ath' },
      },
      {
        mode = 'i',
        { 'jk', '<Esc>l', desc = 'Exit insert mode' },
      },
      {
        mode = 'x',
        { '<leader><leader>', 'gc', desc = '[ ] Toggle Comment', remap = true },
        { '<',                '<gv' },
        { '>',                '>gv' },
      },
      {
        mode = 't',
        { '<C-q>', '<C-\\><C-n>',         desc = 'Exit terminal mode' },
        { '<A-h>', [[<Cmd>wincmd h<CR>]], desc = 'Move focus to the left window' },
        { '<A-j>', [[<Cmd>wincmd j<CR>]], desc = 'Move focus to the lower window' },
        { '<A-k>', [[<Cmd>wincmd k<CR>]], desc = 'Move focus to the upper window' },
        { '<A-l>', [[<Cmd>wincmd l<CR>]], desc = 'Move focus to the right window' },
      },
      {
        mode = { 'n', 'v' }, -- NORMAL and VISUAL mode
        { '<leader>w',  '<cmd>write<CR>',                           desc = 'Buffer - [W]rite' },
        { '<leader>zq', '<Cmd>q<CR>',                               desc = '[Q]uit' },
        { '<leader>zQ', '<Cmd>qa<CR>',                              desc = '[Q]uit All' },
        { '<leader>p',  '"_dP',                                     desc = 'Cursor - [P]aste copied text' },
        { '<leader>j',  '10j',                                      desc = 'Cursor - [j] * 10' },
        { '<leader>k',  '10k',                                      desc = 'Cursot - [k] * 10' },
        { '<leader>Q',  function() vim.diagnostic.open_float() end, desc = '[Q]uickfix - Diagnostics Window' },
        { '<leader>q',  function() vim.diagnostic.setloclist() end, desc = '[Q]uickfix - Diagnostics List' },
      },
    }
  end,
}
