return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- stylua: ignore
    vim.keymap.set('n', '<leader>H',    function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon - Toggle Menu' })
    vim.keymap.set('n', '<leader>h',  function() harpoon:list():add() end,                         { desc = 'Harpoon - Add Buffer' })
    vim.keymap.set('n', '<leader>;',     function() harpoon:list():select(1) end,                     { desc = 'Harpoon - [1] Select Buffer' })
    vim.keymap.set('n', '<leader>\'',     function() harpoon:list():select(2) end,                     { desc = 'Harpoon - [2] Select Buffer' })
    vim.keymap.set('n', '<leader>[',     function() harpoon:list():select(3) end,                     { desc = 'Harpoon - [3] Select Buffer' })
    vim.keymap.set('n', '<leader>]',     function() harpoon:list():select(4) end,                     { desc = 'Harpoon - [4] Select Buffer' })
    -- vim.keymap.set('n', '<leader>h5',     function() harpoon:list():select(5) end,                     { desc = 'Harpoon - [5] Select Buffer' })
    -- vim.keymap.set('n', '<leader>h6',     function() harpoon:list():select(6) end,                     { desc = 'Harpoon - [6] Select Buffer' })
    -- vim.keymap.set('n', '<leader>h7',     function() harpoon:list():select(7) end,                     { desc = 'Harpoon - [7] Select Buffer' })
    -- vim.keymap.set('n', '<leader>h8',     function() harpoon:list():select(8) end,                     { desc = 'Harpoon - [8] Select Buffer' })
    -- vim.keymap.set('n', '<leader>h9',     function() harpoon:list():select(9) end,                     { desc = 'Harpoon - [9] Select Buffer' })
    -- vim.keymap.set('n', '<leader>h0',     function() harpoon:list():select(0) end,                     { desc = 'Harpoon - [0] Select Buffer' })
    vim.keymap.set('n', '[h',                   function() harpoon:list():prev() end,                        { desc = 'Harpoon - Previous' })
    vim.keymap.set('n', ']h',                   function() harpoon:list():next() end,                        { desc = 'Harpoon - Next' })
  end,
}
