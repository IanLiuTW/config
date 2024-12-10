return {
  {
    'FabijanZulj/blame.nvim',
    lazy = true,
    config = function()
      require('blame').setup {
        date_format = '%Y.%m.%d',
        blame_options = { '-w' },
        mappings = {
          commit_info = '<space>',
          stack_push = '<C-B>',
          stack_pop = '<C-F>',
          show_commit = { '<TAB>', '<CR>' },
          close = { '<esc>', 'q' },
        },
        -- format_fn = require("blame.formats.default_formats").date_message,
      }
    end,
    keys = {
      { '<leader>G', '<cmd>BlameToggle<cr>', desc = 'Blame - Toggle' },
    },
  },
}
