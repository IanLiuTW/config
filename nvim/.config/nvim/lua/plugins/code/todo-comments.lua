return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = ' ', -- icon used for the sign, and in search results
        color = 'error', -- can be a hex color, or a named color (see below)
        alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
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
      fg = 'NONE', -- The gui style to use for the fg highlight group.
      bg = 'BOLD', -- The gui style to use for the bg highlight group.
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- list of named colors where we try to extract the guifg from the
    -- list of highlight groups or use the hex color if hl not found as a fallback
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
      -- regex that will be used to match keywords. don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS)(:|!\()]],
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  },
  keys = {
    {
      '];',
      function()
        require('todo-comments').jump_next()
      end,
      mode = 'n',
      desc = 'Todo - Jump to next todo',
    },
    {
      '[;',
      function()
        require('todo-comments').jump_prev()
      end,
      mode = 'n',
      desc = 'Todo - Jump to previous todo',
    },
  },
}
