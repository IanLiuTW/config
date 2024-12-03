return {
  {
    'ziontee113/icon-picker.nvim',
    lazy = true,
    keys = {
      { '<Leader>dq', '<cmd>IconPickerNormal<cr>', desc = 'Icon Picker - Icon insert', noremap = true, silent = true },
      { '<Leader>dQ', '<cmd>IconPickerYank<cr>', desc = 'Icon Picker - Icon yank', noremap = true, silent = true },
      { '<C-Q>', '<cmd>IconPickerInsert<cr>', mode = 'i', desc = 'Icon Picker - Icon insert', noremap = true, silent = true },
    },
    config = function()
      require('icon-picker').setup { disable_legacy_commands = true }
    end,
  },
}
