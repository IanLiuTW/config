return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
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
        open_mapping = [[<C-\>]],
        direction = 'horizontal',
        float_opts = {
          border = 'curved'
        },
        shade_terminals = false,
      }

      vim.keymap.set({ 'n' }, '<leader>\\', '<cmd>ToggleTerm size=40 direction=float<CR>', { desc = 'ToggleTerm - Create Terminal (Float)' })
      vim.keymap.set({ 'n' }, '<leader>-', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'ToggleTerm - Create Terminal (Vertical)' })
      vim.keymap.set({ 'n' }, '<leader>=', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'ToggleTerm - Create Terminal (Horizontal)' })
      vim.keymap.set({ 'n' }, '<leader>|', '<cmd>ToggleTerm direction=tab<CR>', { desc = 'ToggleTerm - Create Terminal (Tab)' })
    end,
  },
}
