return {
  'akinsho/git-conflict.nvim',
  version = '*',
  config = function()
    require('git-conflict').setup {
      default_mappings = false, -- disable the default mappings
      disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
      highlights = {
        incoming = 'DiffAdd', -- highlight for incoming changes
        current = 'DiffText', -- highlight for current changes
      },
    }
    vim.keymap.set('n', '<leader>co', '<Plug>(git-conflict-ours)')
    vim.keymap.set('n', '<leader>ct', '<Plug>(git-conflict-theirs)')
    vim.keymap.set('n', '<leader>ca', '<Plug>(git-conflict-both)')
    vim.keymap.set('n', '<leader>cn', '<Plug>(git-conflict-none)')
    -- vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)')
    -- vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)')
  end,
}
