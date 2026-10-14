return {
  'max397574/better-escape.nvim',
  event = 'InsertEnter',
  config = function()
    require('better_escape').setup {
      timeout = vim.o.timeoutlen,
      default_mappings = true,
      mappings = {
        i = {
          j = {
            k = '<Esc>',
          },
        },
        c = {
          j = {
            k = '<C-c>',
          },
        },
        t = {
          j = {
            k = '<C-\\><C-n>',
          },
        },
        v = {},
        s = {
          j = {
            k = '<Esc>',
          },
        },
      },
    }
  end,
}
