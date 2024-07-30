return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>0', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H]arpoon Toggle' })
    vim.keymap.set('n', '<leader>`', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [A]dd' })

    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = '[1] Harpoon Selection' })
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = '[2] Harpoon Selection' })
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = '[3] Harpoon Selection' })
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = '[4] Harpoon Selection' })
    vim.keymap.set('n', '<leader>5', function()
      harpoon:list():select(5)
    end, { desc = '[5] Harpoon Selection' })
    vim.keymap.set('n', '<leader>6', function()
      harpoon:list():select(6)
    end, { desc = '[6] Harpoon Selection' })
    vim.keymap.set('n', '<leader>7', function()
      harpoon:list():select(7)
    end, { desc = '[7] Harpoon Selection' })
    vim.keymap.set('n', '<leader>8', function()
      harpoon:list():select(8)
    end, { desc = '[8] Harpoon Selection' })
    vim.keymap.set('n', '<leader>9', function()
      harpoon:list():select(9)
    end, { desc = '[9] Harpoon Selection' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>,', function()
      harpoon:list():prev()
    end, { desc = 'Select [H]arpoon [P]revious)' })
    vim.keymap.set('n', '<leader>.', function()
      harpoon:list():next()
    end, { desc = 'Select [H]arpoon [N]ext' })

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
    vim.keymap.set('n', '<leader>s`', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon wiindow' })
  end,
}
