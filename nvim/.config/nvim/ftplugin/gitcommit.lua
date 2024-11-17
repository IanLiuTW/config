local function get_git_branch()
  local handle = io.popen 'git branch --show-current 2>/dev/null'
  if handle then
    local branch = handle:read('*a'):match '%S+'
    handle:close()
    return branch
  end
  return nil
end

vim.keymap.set('n', '<C-y>', ':wq<cr>', { buffer = true, noremap = true, silent = true })
vim.keymap.set('n', '<C-e>', ':q!<cr>', { buffer = true, noremap = true, silent = true })
vim.keymap.set({ 'n', 'i' }, '<C-cr>', function()
  vim.api.nvim_put({ get_git_branch() .. ': ' }, 'c', true, true)
end, { buffer = true, noremap = true, silent = true })
