local function list()
  return require('harpoon'):list()
end

-- stylua: ignore
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false, -- setup() registers the autocmds that track cursor positions in listed files
  keys = {
    { '<leader>`', function() require('harpoon').ui:toggle_quick_menu(list()) end, desc = 'Harpoon - Menu' },
    { '<leader>~', function() list():add() end,                                   desc = 'Harpoon - Add file' },
    { '<leader>1', function() list():select(1) end,                               desc = 'Harpoon - Go to 1' },
    { '<leader>2', function() list():select(2) end,                               desc = 'Harpoon - Go to 2' },
    { '<leader>3', function() list():select(3) end,                               desc = 'Harpoon - Go to 3' },
    { '<leader>4', function() list():select(4) end,                               desc = 'Harpoon - Go to 4' },
    { '<leader>5', function() list():select(5) end,                               desc = 'Harpoon - Go to 5' },
    { '<leader>6', function() list():select(6) end,                               desc = 'Harpoon - Go to 6' },
    { '[h',        function() list():prev() end,                                  desc = 'Harpoon - Previous' },
    { ']h',        function() list():next() end,                                  desc = 'Harpoon - Next' },
  },
  config = function()
    require('harpoon'):setup()
  end,
}
