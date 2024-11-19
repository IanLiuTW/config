local function setupCustomHighlightGroup()
  vim.api.nvim_command 'hi clear FlashMatch'
  vim.api.nvim_command 'hi clear FlashCurrent'
  vim.api.nvim_command 'hi clear FlashLabel'

  vim.api.nvim_command 'hi FlashMatch guifg=#b8b5ff guibg=#4a47a3'
  vim.api.nvim_command 'hi FlashCurrent guifg=#d0e8f2 guibg=#456268'
  vim.api.nvim_command 'hi FlashLabel cterm=bold gui=bold guifg=#c0caf5 guibg=#ff007c'
end

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = '',
  callback = function()
    setupCustomHighlightGroup()
  end,
})

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    rainbow = {
      enabled = true,
      shade = 5,
    },
    highlight = {
      backdrop = true,
      groups = {
        match = 'FlashMatch',
        current = 'FlashCurrent',
        backdrop = 'FlashBackdrop',
        label = 'FlashLabel',
      },
    },
  },
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash - Jump' },
    { 'S', mode = { 'o' }, function() require('flash').remote() end, desc = 'Flash - Remote Action' },
    { '<leader>Q', mode = { 'n', 'x' }, function() require('flash').jump {
      matcher = function(win)
        return vim.tbl_map(function(diag)
          return {
            pos = { diag.lnum + 1, diag.col },
            end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
          }
        end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
      end,
      search = { mode = "search", max_length = 0 },
      label = { after = { 0, 0 } },
      action = function(match, state)
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          vim.diagnostic.open_float({source = true, border="rounded"})
        end)
        state:restore()
      end,
    } end, desc = 'Flash - Remote Diagnostic' },
    { '<leader>A', mode = { 'n', 'x' }, function() require('flash').jump {
      matcher = function(win)
        return vim.tbl_map(function(diag)
          return {
            pos = { diag.lnum + 1, diag.col },
            end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
          }
        end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
      end,
      search = { mode = "search", max_length = 0 },
      label = { after = { 0, 0 } },
      action = function(match, state)
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          vim.lsp.buf.code_action()
        end)
        state:restore()
      end,
    } end, desc = 'Flash - Remote Diagnostic' },
    { '<leader>x', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash - Treesitter' },
    { '<leader>X', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter_search() end, desc = 'Flash - Treesitter Jump' },
    { '<leader>K', mode = { 'n', 'x', 'o' }, function() require('flash').jump { search = { mode = 'search', max_length = 0 }, label = { after = { 0, 0 } }, pattern = '^' } end, desc = 'Flash - Jump Line' },
    { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Flash - Toggle Flash Search' },
  },
}
