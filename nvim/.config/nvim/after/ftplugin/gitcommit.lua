local function get_git_branch()
  local handle = io.popen 'git branch --show-current 2>/dev/null'
  if handle then
    local branch = handle:read('*a'):match '%S+'
    handle:close()
    return branch
  end
  return nil
end

vim.keymap.set({ 'n', 'i' }, '<S-CR>', function()
  local branch = get_git_branch()
  if not branch then
    vim.notify('No current branch (detached HEAD?)', vim.log.levels.WARN)
    return
  end
  vim.api.nvim_put({ branch .. ': ' }, 'c', true, true)
end, { buffer = true, noremap = true, silent = true })
