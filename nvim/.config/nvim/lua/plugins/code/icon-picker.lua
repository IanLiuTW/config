return {
  {
    'ziontee113/icon-picker.nvim',
    config = function()
      require('icon-picker').setup { disable_legacy_commands = true }

      vim.keymap.set('n', '<Leader>cq', '<cmd>IconPickerNormal<cr>', { desc = 'Icon Picker - Icon insert', noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>cQ', '<cmd>IconPickerYank<cr>', { desc = 'Icon Picker - Icon yank', noremap = true, silent = true })
      vim.keymap.set('i', '<C-q>', '<cmd>IconPickerInsert<cr>', { desc = 'Icon Picker - Icon insert', noremap = true, silent = true })
    end,
  },
}
