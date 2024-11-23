return {
  {
    'FabijanZulj/blame.nvim',
    lazy = true,
    config = function()
      require('blame').setup {
        date_format = '%Y.%d.%m',
        blame_options = { '-w' },
        mappings = {
          commit_info = '<space>',
          stack_push = '<C-L>',
          stack_pop = '<C-H>',
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
