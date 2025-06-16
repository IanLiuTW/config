-- vim.api.nvim_create_autocmd('Colorscheme', {
--   group = vim.api.nvim_create_augroup('config_custom_highlights_barbar', {}),
--   callback = function()
    -- Override colorscheme settings before the colorscheme 'load()' call
    -- local tablinesel_hl = vim.api.nvim_get_hl(0, { name = 'TabLineFill' })

    -- vim.api.nvim_set_hl(0, 'BufferCurrentADDED', {
    --   bg = tablinesel_hl.bg and string.format('#%06x', tablinesel_hl.bg),
    --   fg = '#7EA662',
    -- })
    -- vim.api.nvim_set_hl(0, 'BufferCurrentCHANGED', {
    --   bg = tablinesel_hl.bg and string.format('#%06x', tablinesel_hl.bg),
    --   fg = '#4FA6ED',
    -- })
    -- vim.api.nvim_set_hl(0, 'BufferCurrentDELETED', {
    --   bg = tablinesel_hl.bg and string.format('#%06x', tablinesel_hl.bg),
    --   fg = '#E55561',
    -- })
    -- vim.api.nvim_set_hl(0, 'BufferCurrentERROR', {
    --   bg = tablinesel_hl.bg and string.format('#%06x', tablinesel_hl.bg),
    --   fg = '#7EA662',
    -- })
    -- vim.api.nvim_set_hl(0, 'BufferCurrentHINT', {
    --   bg = tablinesel_hl.bg and string.format('#%06x', tablinesel_hl.bg),
    --   fg = '#7EA662',
    -- })
--   end,
-- })

return {
  'romgrk/barbar.nvim',
  lazy = false,
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  keys = {
    -- { '<leader>{', '<Cmd>BufferMovePrevious<CR>', noremap = true, silent = true, desc = 'Buffer - Move Privious' },
    -- { '<leader>}', '<Cmd>BufferMoveNext<CR>', noremap = true, silent = true, desc = 'Buffer - Move Next' },
    { '<C-,>', '<Cmd>BufferPrevious<CR>', noremap = true, silent = true, desc = 'Buffer - Previous' },
    { '<C-.>', '<Cmd>BufferNext<CR>', noremap = true, silent = true, desc = 'Buffer - Next' },
    { '<C-S-,>', '<Cmd>BufferMovePrevious<CR>', noremap = true, silent = true, desc = 'Buffer - Move Privious' },
    { '<C-S-.>', '<Cmd>BufferMoveNext<CR>', noremap = true, silent = true, desc = 'Buffer - Move Next' },
    { '<C-1>', '<Cmd>BufferGoto 1<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 1' },
    { '<C-2>', '<Cmd>BufferGoto 2<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 2' },
    { '<C-3>', '<Cmd>BufferGoto 3<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 3' },
    { '<C-4>', '<Cmd>BufferGoto 4<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 4' },
    { '<C-5>', '<Cmd>BufferGoto 5<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 5' },
    { '<C-6>', '<Cmd>BufferGoto 6<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 6' },
    { '<C-7>', '<Cmd>BufferGoto 7<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 7' },
    { '<C-8>', '<Cmd>BufferGoto 8<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 8' },
    { '<C-9>', '<Cmd>BufferGoto 9<CR>', noremap = true, silent = true, desc = 'Buffer - Goto 9' },
    { '<C-0>', '<Cmd>BufferLast<CR>', noremap = true, silent = true, desc = 'Buffer - Last' },

    { '<leader>B', '<Cmd>BufferPin<CR>', noremap = true, silent = true, desc = 'Buffer - Pin' },
    { '<leader>b<space>', '<Cmd>BufferPick<CR>', noremap = true, silent = true, desc = 'Buffer - Pick' },

    { '<leader>bo', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', noremap = true, silent = true, desc = 'Buffer - Close All but Current or Pinned' },
    { '<leader>br', '<Cmd>BufferCloseBuffersRight<CR>', noremap = true, silent = true, desc = 'Buffer - Close All on the Right' },

    { '<leader>bN', '<Cmd>BufferOrderByBufferNumber<CR>', noremap = true, silent = true, desc = 'Buffer - Order by Number' },
    { '<leader>bT', '<Cmd>BufferOrderByName<CR>', noremap = true, silent = true, desc = 'Buffer - Order by Name' },
    { '<leader>bD', '<Cmd>BufferOrderByDirectory<CR>', noremap = true, silent = true, desc = 'Buffer - Order by Directory' },
    { '<leader>bL', '<Cmd>BufferOrderByLanguage<CR>', noremap = true, silent = true, desc = 'Buffer - Order by Language' },
    { '<leader>bW', '<Cmd>BufferOrderByWindowNumber<CR>', noremap = true, silent = true, desc = 'Buffer - Order by WindowNumber' },
  },
  opts = {
    animation = false,
    focus_on_close = 'left',
    icons = {
      buffer_index = true,
      buffer_number = false,
      button = '󰅙',
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = false },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
      separator = { left = '█', right = '' },
      modified = { button = '󱗽' },
      pinned = { button = '', filename = true },
      current = { buffer_index = false },
      inactive = { button = '󰅚' },
    },
  },
}
