return {
  'max397574/better-escape.nvim',
  event = 'InsertEnter',
  opts = {
    mappings = {
      -- Visual-mode jk would swallow a j-then-k selection
      v = { j = { k = false } },
    },
  },
}
