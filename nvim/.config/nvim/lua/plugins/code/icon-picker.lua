return {
  {
    'ziontee113/icon-picker.nvim',
    config = function()
      require('icon-picker').setup { disable_legacy_commands = true }

      vim.keymap.set('n', '<Leader>cy', '<cmd>IconPickerNormal<cr>', { desc = '[I]con insert', noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>cY', '<cmd>IconPickerYank<cr>', { desc = '[I]con yank', noremap = true, silent = true })
      vim.keymap.set('i', '<A-y>', '<cmd>IconPickerInsert<cr>', { desc = '[I]con insert', noremap = true, silent = true })
    end,
  },
}
