local kulala = require 'kulala'

vim.keymap.set('n', '<CR>', function()
  kulala.run()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Run' })
vim.keymap.set('n', '<S-CR>', function()
  kulala.run_all()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Run All' })
vim.keymap.set('n', '<C-CR>', function()
  kulala.replay()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Replay' })
vim.keymap.set('n', '<space>', function()
  kulala.inspect()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Inspect' })
vim.keymap.set('n', '<s-tab>', function()
  kulala.show_stats()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Show Stats' })
vim.keymap.set('n', '<tab>', function()
  kulala.toggle_view()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Toggle View' })
vim.keymap.set('n', '/', function()
  kulala.search()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Search' })
vim.keymap.set('n', '{', function()
  kulala.jump_prev()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Jump Previous' })
vim.keymap.set('n', '}', function()
  kulala.jump_next()
end, { noremap = true, silent = true, buffer = true, desc = 'Kulala - Jump Next' })
vim.keymap.set('n', 'q', '<cmd>bd!<cr>', { noremap = true, silent = true, buffer = true, desc = 'Kulala - Close' })