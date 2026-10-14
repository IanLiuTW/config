return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true,
    sign_priority = 8,
    keywords = {
      FIX = {
        icon = ' ',
        color = 'error',
        alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
      },
      TODO = { icon = ' ', color = 'info', alt = { 'todo', 'unimplemented' } },
      HACK = { icon = ' ', color = 'warning' },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
      DBG = { icon = ' ', color = 'debug', alt = { 'DEBUG', 'DEBUGGING', 'TMP' } },
      PERF = { icon = ' ', alt = { 'OPTIM' } },
      NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
    gui_style = {
      fg = 'NONE',
      bg = 'BOLD',
    },
    merge_keywords = true,
    colors = {
      error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
      warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
      info = { 'DiagnosticInfo', '#2563EB' },
      hint = { 'DiagnosticHint', '#10B981' },
      default = { 'Identifier', '#7C3AED' },
      test = { 'Identifier', '#FF00FF' },
      debug = { '#e800ae' },
    },
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
      pattern = [[\b(KEYWORDS)(:|!\()]],
    },
  },
  keys = {
    {
      '];',
      function()
        require('todo-comments').jump_next()
      end,
      mode = 'n',
      desc = 'Jump - Next todo comment',
    },
    {
      '[;',
      function()
        require('todo-comments').jump_prev()
      end,
      mode = 'n',
      desc = 'Jump - Previous todo comment',
    },
  },
}
