return {
  'uga-rosa/ccc.nvim',
  lazy = true,
  event = 'BufRead',
  commands = {
    'CccPick',
    'CccHighlighterToggle',
  },
  keys = {
    {
      '<leader>d/',
      '<Cmd>CccPick<CR>',
      desc = 'Color Code - Pick Color Code',
    },
    {
      '<leader>d?',
      '<Cmd>CccHighlighterToggle<CR>',
      desc = 'Color Code - Toggle Highlighter',
    },
  },
  config = function()
    local ccc = require 'ccc'
    local mapping = ccc.mapping
    ccc.setup {
      -- Your preferred settings
      -- Example: enable highlighter
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    }
  end,
}
