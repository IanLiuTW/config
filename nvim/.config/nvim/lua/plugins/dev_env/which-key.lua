return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = '[?] Buffer Local Keymaps',
    },
  },
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup {
      win = {
        width = { min = 30, max = 120 },
        height = { min = 4, max = 0.99 },
        padding = { 0, 1 },
        col = -1,
        row = -1,
        border = 'rounded',
        title = true,
        title_pos = 'left',
      },
      layout = {
        width = { min = 100, max = 120 },
      },
    }
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ebug' },
      { '<leader>s', group = '[S]earch', mode = { 'n', 'x' } },
      { '<leader>t', group = '[T]erminal' },
      { '<leader>g', group = '[G]it', mode = { 'n', 'x' } },
      { '<leader>b', group = '[B]uffer' },
      { '<leader>l', group = '[L] Tasks' },
      { '<leader>r', group = 'Su[R]round', mode = { 'n', 'x' } },
      { '<leader>\\', group = '[,] Plugin / Session' },
      { '<leader>z', group = 'Extra[Z]', mode = { 'n', 'x' } },
      {
        mode = { 'n', 'v' }, -- NORMAL and VISUAL mode
        { '<leader>w', '<cmd>write<CR>', desc = '[W]rite buffer' },
        { '<leader>zq', '<Cmd>q<CR>', desc = '[Q]uit' },
        { '<leader>zQ', '<Cmd>qa<CR>', desc = '[Q]uit All' },
        { '<leader>p', '"0p', desc = '[P]aste copied text' },
        { '<leader>j', '10j', desc = '[J] * 10' },
        { '<leader>k', '10k', desc = '[K] * 10' },
        {
          '<leader>Q',
          function()
            vim.diagnostic.open_float()
          end,
          desc = '[Q]uick Diagnostics Window',
        },
        {
          '<leader>q',
          function()
            vim.diagnostic.setloclist()
          end,
          desc = '[Q]uickfix Diagnostic List',
        },
      },
    }
  end,
}
