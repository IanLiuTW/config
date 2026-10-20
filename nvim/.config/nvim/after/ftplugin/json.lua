-- `o` first appends a comma to the current line unless it ends in `,`, `{` or `[`
-- Trailing whitespace is ignored and dropped
vim.keymap.set('n', 'o', function()
  local line = vim.api.nvim_get_current_line()
  local trimmed = line:gsub('%s+$', '')
  if trimmed:find '[^,{[]$' then
    return 'A' .. ('<BS>'):rep(#line - #trimmed) .. ',<cr>'
  end
  return 'o'
end, { buffer = true, expr = true })
