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
      '<leader>cc',
      '<Cmd>CccPick<CR>',
      desc = '[#] Pick Color Code',
    },
    {
      '<leader>cC',
      '<Cmd>CccHighlighterToggle<CR>',
      desc = '[#] Pick Color Code',
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
