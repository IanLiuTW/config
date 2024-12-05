return {
  'mbbill/undotree',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<leader>u', '<CMD>UndotreeToggle<CR>', { desc = '[U]ndo Tree - Toggle' })
  end
}
