return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function ()
    vim.g.codeium_disable_bindings = 1
    vim.keymap.set('i', '<Esc>', function () return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<A-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<A-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<A-Cr>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<A-\\>', function () return vim.fn['codeium#Complete']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<A-l>', function () return vim.fn['codeium#AcceptNextWord']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<A-j>', function () return vim.fn['codeium#AcceptNextLine']() end, { expr = true, silent = true })

    vim.keymap.set('n', '<A-a>\\', ":CodeiumToggle<CR>", { silent = true })
    vim.keymap.set('n', '<A-a><Space>', ":call codeium#Chat()<CR>", { silent = true })
    vim.keymap.set('n', '<C-c>', function () return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  end
}
-- return {
--   'Exafunction/codeium.nvim',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'hrsh7th/nvim-cmp',
--   },
--   config = function()
--     require('codeium').setup {
--       enable_chat = true,
--     }
--     vim.api.nvim_set_keymap('n', '<A-c>', ':Codeium Chat<CR>', { noremap = true, silent = true })
--   end,
-- }
