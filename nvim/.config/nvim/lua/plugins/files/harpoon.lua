return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- stylua: ignore
    vim.keymap.set('n', '<leader>`',    function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon - Toggle Menu' })
    vim.keymap.set('n', '<leader>~',  function() harpoon:list():add() end,                         { desc = 'Harpoon - Add Buffer' })
    vim.keymap.set('n', '<leader>1',     function() harpoon:list():select(1) end,                     { desc = 'Harpoon - [1] Select Buffer' })
    vim.keymap.set('n', '<leader>2',     function() harpoon:list():select(2) end,                     { desc = 'Harpoon - [2] Select Buffer' })
    vim.keymap.set('n', '<leader>3',     function() harpoon:list():select(3) end,                     { desc = 'Harpoon - [3] Select Buffer' })
    vim.keymap.set('n', '<leader>4',     function() harpoon:list():select(4) end,                     { desc = 'Harpoon - [4] Select Buffer' })
    vim.keymap.set('n', '<leader>5',     function() harpoon:list():select(5) end,                     { desc = 'Harpoon - [5] Select Buffer' })
    vim.keymap.set('n', '<leader>6',     function() harpoon:list():select(6) end,                     { desc = 'Harpoon - [6] Select Buffer' })
    vim.keymap.set('n', '[h',                   function() harpoon:list():prev() end,                        { desc = 'Harpoon - Previous' })
    vim.keymap.set('n', ']h',                   function() harpoon:list():next() end,                        { desc = 'Harpoon - Next' })
  end,
}
