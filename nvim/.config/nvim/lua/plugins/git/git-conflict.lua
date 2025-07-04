return {
  'akinsho/git-conflict.nvim',
  version = '*',
  config = true,
  opt = {
    default_mappings = {
      ours = 'o',
      theirs = 't',
      none = '0',
      both = 'b',
      next = 'n',
      prev = 'p',
    },
    disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
    highlights = { -- They must have background color, otherwise the default color will be used
      incoming = 'DiffAdd',
      current = 'DiffText',
    },
  },
}
