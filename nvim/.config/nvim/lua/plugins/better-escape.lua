return {
  'max397574/better-escape.nvim',
  config = function()
    require('better_escape').setup {
      timeout = vim.o.timeoutlen, -- after `timeout` passes, you can press the escape key and the plugin will ignore it
      default_mappings = true, -- setting this to false removes all the default mappings
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
        v = {
          -- j = {
          --   k = '<Esc>',
          -- },
        },
        s = {
          j = {
            k = '<Esc>',
          },
        },
      },
    }
  end,
}
