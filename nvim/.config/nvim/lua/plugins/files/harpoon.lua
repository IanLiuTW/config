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
    { '<leader>`', function() require('harpoon').ui:toggle_quick_menu(list()) end, desc = 'Harpoon - Toggle Menu' },
    { '<leader>~', function() list():add() end,                                   desc = 'Harpoon - Add Buffer' },
    { '<leader>1', function() list():select(1) end,                               desc = 'Harpoon - [1] Select Buffer' },
    { '<leader>2', function() list():select(2) end,                               desc = 'Harpoon - [2] Select Buffer' },
    { '<leader>3', function() list():select(3) end,                               desc = 'Harpoon - [3] Select Buffer' },
    { '<leader>4', function() list():select(4) end,                               desc = 'Harpoon - [4] Select Buffer' },
    { '<leader>5', function() list():select(5) end,                               desc = 'Harpoon - [5] Select Buffer' },
    { '<leader>6', function() list():select(6) end,                               desc = 'Harpoon - [6] Select Buffer' },
    { '[h',        function() list():prev() end,                                  desc = 'Harpoon - Previous' },
    { ']h',        function() list():next() end,                                  desc = 'Harpoon - Next' },
  },
  config = function()
    require('harpoon'):setup()
  end,
}
