return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- stylua: ignore
    vim.keymap.set('n', '<leader>H',    function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon - Toggle Menu' })
    vim.keymap.set('n', '<leader>hh',  function() harpoon:list():add() end,                         { desc = 'Harpoon - Add Buffer' })
    vim.keymap.set('n', '<leader>h1',     function() harpoon:list():select(1) end,                     { desc = 'Harpoon - [1] Select Buffer' })
    vim.keymap.set('n', '<leader>h2',     function() harpoon:list():select(2) end,                     { desc = 'Harpoon - [2] Select Buffer' })
    vim.keymap.set('n', '<leader>h3',     function() harpoon:list():select(3) end,                     { desc = 'Harpoon - [3] Select Buffer' })
    vim.keymap.set('n', '<leader>h4',     function() harpoon:list():select(4) end,                     { desc = 'Harpoon - [4] Select Buffer' })
    vim.keymap.set('n', '<leader>h5',     function() harpoon:list():select(5) end,                     { desc = 'Harpoon - [5] Select Buffer' })
    vim.keymap.set('n', '<leader>h6',     function() harpoon:list():select(6) end,                     { desc = 'Harpoon - [6] Select Buffer' })
    vim.keymap.set('n', '<leader>h7',     function() harpoon:list():select(7) end,                     { desc = 'Harpoon - [7] Select Buffer' })
    vim.keymap.set('n', '<leader>h8',     function() harpoon:list():select(8) end,                     { desc = 'Harpoon - [8] Select Buffer' })
    vim.keymap.set('n', '<leader>h9',     function() harpoon:list():select(9) end,                     { desc = 'Harpoon - [9] Select Buffer' })
    vim.keymap.set('n', '<leader>h0',     function() harpoon:list():select(0) end,                     { desc = 'Harpoon - [0] Select Buffer' })
    vim.keymap.set('n', '[h',                   function() harpoon:list():prev() end,                        { desc = 'Harpoon - Previous' })
    vim.keymap.set('n', ']h',                   function() harpoon:list():next() end,                        { desc = 'Harpoon - Next' })

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end
    vim.keymap.set('n', '<leader>hH', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon - Search Harpoon List' })
  end,
}
