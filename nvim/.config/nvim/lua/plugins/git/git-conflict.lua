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
  },
}
