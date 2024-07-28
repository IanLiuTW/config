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
          border = 'curved',
        },
        shade_terminals = false,
      }

      vim.keymap.set({ 'n' }, '<leader>t<space>', '<cmd>ToggleTerm size=40 direction=float<CR>', { desc = 'Create a float terminal' })
      vim.keymap.set({ 'n' }, '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Create a vertical terminal' })
      vim.keymap.set({ 'n' }, '<leader>ts', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Create a horizontal terminal' })
      vim.keymap.set({ 'n' }, '<leader>tt', '<cmd>ToggleTerm direction=tab<CR>', { desc = 'Create a tab terminal' })
    end,
  },
}
