return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    search = {
      command = 'rg',
      args = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--hidden',
      },
    },
  },
  init = function()
    vim.keymap.set('n', '].', function()
      require('todo-comments').jump_next()
    end, { desc = 'Jump to next todo' })

    vim.keymap.set('n', '[.', function()
      require('todo-comments').jump_prev()
    end, { desc = 'Jump to previous todo' })
  end,
}
