return {
  {
    'ziontee113/icon-picker.nvim',
    lazy = true,
    keys = {
      { '<F4>', '<cmd>IconPickerNormal<cr>', desc = 'Icon Picker - Icon insert', noremap = true, silent = true },
      { '<F4>', '<cmd>IconPickerYank<cr>', desc = 'Icon Picker - Icon yank', noremap = true, silent = true },
      { '<F4>', '<cmd>IconPickerInsert<cr>', mode = 'i', desc = 'Icon Picker - Icon insert', noremap = true, silent = true },
    },
    config = function()
      require('icon-picker').setup { disable_legacy_commands = true }
    end,
  },
}
