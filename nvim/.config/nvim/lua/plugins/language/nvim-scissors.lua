return {
  'chrisgrieser/nvim-scissors',
  lazy = true,
  keys = {
    { '<leader>d[', function() require('scissors').editSnippet() end, mode = {'n'}, desc = 'Edit - Edit snippet' },
    { '<leader>d]', function() require('scissors').addNewSnippet() end, mode = {'n', 'x'}, desc = 'Edit - Add snippet' },
  },
  opts = {
    snippetDir = '~/.config/nvim/snippets',
  },
}
