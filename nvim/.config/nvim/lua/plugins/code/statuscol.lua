return {
  'luukvbaal/statuscol.nvim',
  lazy = false,
  config = function()
    local builtin = require 'statuscol.builtin'
    require('statuscol').setup {
      relculright = true,
      ft_ignore = {
        'man',
        'starter',
        'TelescopePrompt',
        'dapui_scopes',
        'dapui_breakpoints',
        'dapui_stacks',
        'dapui_watches',
        'dashboard',
        'NvimTree',
      },
      segments = {
        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
        { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
        {
          sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = 'v:lua.ScSa',
        },
        {
          sign = { namespace = { 'diagnostic/signs', 'gitsigns' }, maxwidth = 1, auto = false },
          click = 'v:lua.ScSa',
        },
        -- Uncomment the next 2 lines to make diagnostic and gitsigns separate
        -- { sign = { namespace = { 'diagnostic/signs' }, maxwidth = 1, auto = false }, click = 'v:lua.ScSa', },
        -- { sign = { namespace = { 'gitsigns' }, maxwidth = 1, colwidth = 1, wrap = true, }, },
      },
    }
  end,
}
