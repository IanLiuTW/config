return {
  'chrisgrieser/nvim-scissors',
  dependencies = 'nvim-telescope/telescope.nvim',
  lazy = true,
  keys = {
    { '<leader>d[', function() require('scissors').editSnippet() end, mode = {'n'}, desc = 'Scissors - Search Snippets' },
    { '<leader>d]', function() require('scissors').addNewSnippet() end, mode = {'n', 'n'}, desc = 'Scissors - Search Snippets' },
  },
  opts = {
    snippetDir = '~/.config/nvim/snippets',
  },
}
