return {
  {
    'ziontee113/icon-picker.nvim',
    config = function()
      require('icon-picker').setup { disable_legacy_commands = true }

      vim.keymap.set('n', '<Leader>cu', '<cmd>IconPickerNormal<cr>', { desc = '[I]con insert', noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>cU', '<cmd>IconPickerYank<cr>', { desc = '[I]con yank', noremap = true, silent = true })
      vim.keymap.set('i', '<A-u>', '<cmd>IconPickerInsert<cr>', { desc = '[I]con insert', noremap = true, silent = true })
    end,
  },
}
