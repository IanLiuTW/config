vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<c-w>q', { noremap = true, silent = true })
-- Restore the built-in <CR> jump, which the global flash <CR> mapping would shadow
vim.keymap.set('n', '<CR>', '<CR>', { buffer = true })
