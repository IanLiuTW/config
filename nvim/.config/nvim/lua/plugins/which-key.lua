local function get_vim_unimpaired_mappings()
  local options = function(keyPrefix, namePrefix)
    return {
      { keyPrefix, group = namePrefix },
      { keyPrefix .. 'b', desc = namePrefix .. ' background' },
      { keyPrefix .. 'c', desc = namePrefix .. ' cursorline' },
      { keyPrefix .. 'd', desc = namePrefix .. ' diff' },
      { keyPrefix .. 'h', desc = namePrefix .. ' hlsearch' },
      { keyPrefix .. 'i', desc = namePrefix .. ' ignorecase' },
      { keyPrefix .. 'l', desc = namePrefix .. ' list' },
      { keyPrefix .. 'n', desc = namePrefix .. ' number' },
      { keyPrefix .. 'r', desc = namePrefix .. ' relativenumber' },
      { keyPrefix .. 's', desc = namePrefix .. ' spell' },
      { keyPrefix .. 't', desc = namePrefix .. ' colorcolumn' },
      { keyPrefix .. 'u', desc = namePrefix .. ' cursorcolumn' },
      { keyPrefix .. 'v', desc = namePrefix .. ' virtualedit' },
      { keyPrefix .. 'w', desc = namePrefix .. ' wrap' },
      { keyPrefix .. 'x', desc = namePrefix .. ' cursorline + cursorcolumn' },
    }
  end

  local previous = function(keyPrefix, groupName, isPrevious)
    local above = isPrevious and 'above' or 'below'
    local prev = isPrevious and 'prev' or 'next'
    local first = isPrevious and 'first' or 'last'
    local last = isPrevious and 'last' or 'first'
    local p = {
      p = 'put ' .. above,
      P = 'put ' .. above,
      a = prev .. ' file in argument list', --next
      A = first .. ' file in the argument list.', --last
      q = prev .. ' quickfix entry', --cnext
      Q = first .. ' quickfix entry', --clast
      t = prev .. ' matching tag', --tnext
      T = first .. ' matching tag', --tlast
      l = prev .. ' locationlist entry', --lnext
      L = first .. ' locationlist entry', --llast
      b = prev .. ' buffer in buffer list', --bnext
      B = first .. ' buffer in buffer list', --blast
      f = prev .. ' file in directory',
      n = prev .. ' prev conflict/diff/hunk',
      ['<Space>'] = 'add blank lines ' .. above,
      ['<C-L>'] = last .. ' entry in ' .. prev .. ' file in locationlist', --lnfile
      ['<C-Q>'] = last .. ' entry in ' .. prev .. ' file in quickfixlist', --cnfile
      ['<C-T>'] = prev .. ' matching tag in preview window', --ptnext
    }
    local pp = {
      { keyPrefix, group = groupName },
    }
    for k, v in pairs(p) do
      -- make first char in each str uppercase, and wrap in table
      table.insert(pp, { keyPrefix .. k, name = v:gsub('^%l', string.upper) })
    end
    return pp
  end

  local decoders = function()
    local keyDecoderName = {
      u = 'URL',
      x = 'XML',
      C = 'C String',
      y = 'C String',
    }
    local decoderMaps = {}
    for k, decoderName in pairs(keyDecoderName) do
      table.insert(decoderMaps, {
        mode = { 'n' },
        { '[' .. k .. k, desc = decoderName .. ' encode line' },
        { ']' .. k .. k, desc = decoderName .. ' decode line' },
      })
      table.insert(decoderMaps, {
        mode = { 'v' },
        { '[' .. k, desc = decoderName .. ' encode' },
        { ']' .. k, desc = decoderName .. ' decode' },
      })
    end
    return decoderMaps
  end

  local normals = function()
    local normalMaps = {
      mode = { 'n' },
    }

    vim.list_extend(normalMaps, {
      { '<P', name = 'Paste before linewise, decreasing indent' },
      { '<p', name = 'Paste after linewise, decreasing indent' },
    })
    vim.list_extend(normalMaps, options('<s', 'Enable'))
    vim.list_extend(normalMaps, previous('[', 'Previous', true))
    vim.list_extend(normalMaps, options('[o', 'Enable'))
    vim.list_extend(normalMaps, previous(']', 'Next', false))
    vim.list_extend(normalMaps, options(']o', 'Disable'))
    vim.list_extend(normalMaps, {
      { '>P', name = 'Paste before linewise, increasing indent' },
      { '>p', name = 'Paste after linewise, increasing indent' },
    })
    vim.list_extend(normalMaps, options('>s', 'Disable'))
    vim.list_extend(normalMaps, options('yo', 'Toggle'))
    vim.list_extend(normalMaps, {
      { '=P', name = 'Paste before linewise, reindenting' },
      { '=p', name = 'Paste after linewise, reindenting' },
    })
    vim.list_extend(normalMaps, options('=s', 'Toggle'))

    return normalMaps
  end

  local vim_unimpaired_wk = {}
  vim.list_extend(vim_unimpaired_wk, decoders())
  table.insert(vim_unimpaired_wk, normals())

  return vim_unimpaired_wk
end

local vim_unimpaired_wk = get_vim_unimpaired_mappings()

-- stylua: ignore
return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  lazy = false,
  dependencies = {
    'tpope/vim-unimpaired',
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
      { '<leader>b',        group = '[B]uffer',               mode = { 'n', 'x' } },
      { '<leader>c',        group = '[C]hanges (Gitsigns)',   mode = { 'n', 'x' } },
      { '<leader>d',        group = '[D]o',                   mode = { 'n', 'x' } },
      { '<leader>e',        group = '[E] Debug',              mode = { 'n', 'x' } },
      { '<leader>w',        group = '[W] Trouble',            mode = { 'n', 'x' } },
      { '<leader>g',        group = '[G]it',                  mode = { 'n', 'x' } },
      { '<leader>h',        group = '[H]arpoon',              mode = { 'n', 'x' } },
      { '<leader>s',        group = '[S]urround',             mode = { 'n', 'x' } },
      { '<leader>r',        group = '[R]un',                  mode = { 'n', 'x' } },
      { '<leader>t',        group = '[T]esting',              mode = { 'n', 'x' } },
      { '<leader>y',        group = '[Y] Tasks',              mode = { 'n', 'x' } },
      { '<leader>,',        group = '[,] Settings / Sessions',mode = { 'n', 'x' } },
      { '<leader><leader>', group = '[󱁐] Picker',             mode = { 'n', 'x' } },
      { '<leader>n',        group = '(Empty)',                mode = { 'n', 'x' } },
      { '<leader>l',        group = '(Empty)',                mode = { 'n', 'x' } },

      -- Normal Mode
      {
        mode = 'n',
        { '<Esc>',           '<cmd>nohlsearch<CR>',                         desc = 'nohlsearch' },
        {'<leader>dx',       ':.lua<CR>',                                   desc = 'Execute - Current Line with Lua'},
        {'<leader>dX',       '<CMD>source %<CR>',                           desc = 'Execute - Source Current File'},
        -- User Commands keybindings
        { '<leader>d/',      '<Cmd>CopyPath<CR>',                           desc = 'User Command - Copy Path' },
        { 'dm',              '<Cmd>Delmark<CR>',                            desc = 'User Command - Delete Mark' },
        { '<leader>,v',      '<Cmd>VirtualTextSeverityMinInfo<CR>',         desc = 'User Command - Virtual Text Min Severity: Info' },
        { '<leader>,V',      '<Cmd>VirtualTextSeverityMinHint<CR>',         desc = 'User Command - Virtual Text Min Severity: Hint' },
        -- Plugin keybindings
        { '<leader>,,',      '<Cmd>Lazy<CR>',                               desc = 'Lazy - Open Menu' },
        { '<leader>,u',      '<Cmd>Lazy update<CR>',                        desc = 'Lazy - Update Plugins' },
        { '<leader>,m',      '<cmd>Mason<CR>',                              desc = 'Mason - Open Menu' },
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
        -- { '<leader>w',  '<cmd>write<CR>',                                                           desc = 'Buffer - [W]rite' },
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

    -- Add vim-unimpaired keybindings
    wk.add(vim_unimpaired_wk)
  end,
}
