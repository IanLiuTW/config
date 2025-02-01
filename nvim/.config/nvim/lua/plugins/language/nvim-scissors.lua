return {
  'chrisgrieser/nvim-scissors',
  lazy = true,
  keys = {
    { '<leader>d[', function() require('scissors').editSnippet() end, mode = {'n'}, desc = 'Scissors - Edit Snippets' },
    { '<leader>d]', function() require('scissors').addNewSnippet() end, mode = {'n', 'n'}, desc = 'Scissors - Add New Snippets' },
  },
  opts = {
    snippetDir = '~/.config/nvim/snippets',
  },
}
