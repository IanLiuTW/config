return {
  'rachartier/tiny-code-action.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'folke/snacks.nvim' },
  },
  event = 'LspAttach',
  opts = {
    backend = 'delta',
    picker = 'snacks',
  },
  keys = {
    {
      '<leader>a',
      function()
        require('tiny-code-action').code_action {}
      end,
      desc = 'Code Action',
    },
  },
}
