return {
  'romgrk/barbar.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.g.barbar_auto_setup = false
    -- Load one tick after the first file buffer, so opening a file does not wait on barbar.
    -- showtabline is set at once so the tabline row exists in the first frame and text does not shift.
    vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
      once = true,
      callback = function()
        vim.o.showtabline = 2
        vim.schedule(function()
          require('lazy').load { plugins = { 'barbar.nvim' } }
        end)
      end,
    })
  end,
  keys = {
    { '<C-,>', '<Cmd>BufferPrevious<CR>', noremap = true, silent = true, desc = 'Buffer - Previous' },
    { '<C-.>', '<Cmd>BufferNext<CR>', noremap = true, silent = true, desc = 'Buffer - Next' },
    { '<C-S-,>', '<Cmd>BufferMovePrevious<CR>', noremap = true, silent = true, desc = 'Buffer - Move left' },
    { '<C-S-.>', '<Cmd>BufferMoveNext<CR>', noremap = true, silent = true, desc = 'Buffer - Move right' },
    { '<C-1>', '<Cmd>BufferGoto 1<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 1' },
    { '<C-2>', '<Cmd>BufferGoto 2<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 2' },
    { '<C-3>', '<Cmd>BufferGoto 3<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 3' },
    { '<C-4>', '<Cmd>BufferGoto 4<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 4' },
    { '<C-5>', '<Cmd>BufferGoto 5<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 5' },
    { '<C-6>', '<Cmd>BufferGoto 6<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 6' },
    { '<C-7>', '<Cmd>BufferGoto 7<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 7' },
    { '<C-8>', '<Cmd>BufferGoto 8<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 8' },
    { '<C-9>', '<Cmd>BufferGoto 9<CR>', noremap = true, silent = true, desc = 'Buffer - Go to 9' },
    { '<C-0>', '<Cmd>BufferLast<CR>', noremap = true, silent = true, desc = 'Buffer - Go to last' },

    { '<leader>B', '<Cmd>BufferPin<CR>', noremap = true, silent = true, desc = 'Buffer - Pin' },
    { '<leader>b<space>', '<Cmd>BufferPick<CR>', noremap = true, silent = true, desc = 'Buffer - Pick' },

    { '<leader>bo', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', noremap = true, silent = true, desc = 'Buffer - Close all but current or pinned' },
    { '<leader>br', '<Cmd>BufferCloseBuffersRight<CR>', noremap = true, silent = true, desc = 'Buffer - Close all to the right' },

    { '<leader>bsn', '<Cmd>BufferOrderByBufferNumber<CR>', noremap = true, silent = true, desc = 'Buffer - Sort by buffer number' },
    { '<leader>bsf', '<Cmd>BufferOrderByName<CR>', noremap = true, silent = true, desc = 'Buffer - Sort by file name' },
    { '<leader>bsd', '<Cmd>BufferOrderByDirectory<CR>', noremap = true, silent = true, desc = 'Buffer - Sort by directory' },
    { '<leader>bsl', '<Cmd>BufferOrderByLanguage<CR>', noremap = true, silent = true, desc = 'Buffer - Sort by language' },
    { '<leader>bsw', '<Cmd>BufferOrderByWindowNumber<CR>', noremap = true, silent = true, desc = 'Buffer - Sort by window number' },
  },
  opts = {
    animation = false,
    focus_on_close = 'left',
    icons = {
      buffer_index = 'superscript',
      buffer_number = false,
      button = '󰅙',
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = false },
      },
      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
      separator = { left = '▎', right = '' },
      modified = { button = '󱗽' },
      pinned = { button = '', filename = true },
      current = { buffer_index = false },
      inactive = { button = '󰅚' },
    },
    maximum_padding = 2,
    minimum_padding = 1,
  },
}
