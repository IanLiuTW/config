return {
  'mbbill/undotree',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<leader>u', '<CMD>UndotreeShow<CR>', { desc = '[U]ndo Tree - Show' })
    vim.keymap.set('n', '<leader>U', '<CMD>UndotreeToggle<CR>', { desc = '[U]ndo Tree - Toggle' })
  end
}
