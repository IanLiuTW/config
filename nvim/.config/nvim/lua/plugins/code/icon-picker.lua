return {
  {
    'ziontee113/icon-picker.nvim',
    config = function()
      require('icon-picker').setup { disable_legacy_commands = true }

      vim.keymap.set('n', '<Leader>dq', '<cmd>IconPickerNormal<cr>', { desc = 'Icon Picker - Icon insert', noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>dQ', '<cmd>IconPickerYank<cr>', { desc = 'Icon Picker - Icon yank', noremap = true, silent = true })
      vim.keymap.set('i', '<C-Q>', '<cmd>IconPickerInsert<cr>', { desc = 'Icon Picker - Icon insert', noremap = true, silent = true })
    end,
  },
}
