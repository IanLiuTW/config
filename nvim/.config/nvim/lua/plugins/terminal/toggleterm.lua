return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'BufWinEnter',
    keys = {
      { '<leader>\\', '<cmd>ToggleTerm size=40 direction=float<CR>', desc = 'ToggleTerm - Create Terminal (Float)' },
      { '<leader>-', '<cmd>ToggleTerm direction=vertical<CR>', desc = 'ToggleTerm - Create Terminal (Vertical)' },
      { '<leader>=', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'ToggleTerm - Create Terminal (Horizontal)' },
      { '<leader>|', '<cmd>ToggleTerm direction=tab<CR>', desc = 'ToggleTerm - Create Terminal (Tab)' },
    },
    init = function()
      -- A fix to make toggleterm's background to be dark
      -- local colors = require('tokyonight.colors').setup()
      local toggleterm = require 'toggleterm'
      toggleterm.setup {
        shade_terminals = false,
        highlights = {
          Normal = {
            guibg = '#1c1c1c',
          },
        },
      }
    end,
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          else
            return 20
          end
        end,
        open_mapping = [[<C-/>]],
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        direction = 'horizontal',
        float_opts = {
          border = 'curved',
        },
        shade_terminals = false,
      }
    end,
  },
}
