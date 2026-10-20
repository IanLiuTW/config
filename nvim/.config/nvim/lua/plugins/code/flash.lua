local function setupCustomHighlightGroup()
  vim.api.nvim_command 'hi clear FlashMatch'
  vim.api.nvim_command 'hi clear FlashCurrent'
  vim.api.nvim_command 'hi clear FlashLabel'

  vim.api.nvim_command 'hi FlashMatch guifg=#b8b5ff guibg=#4a47a3'
  vim.api.nvim_command 'hi FlashCurrent guifg=#d0e8f2 guibg=#456268'
  vim.api.nvim_command 'hi FlashLabel cterm=bold gui=bold guifg=#c0caf5 guibg=#ff007c'
end

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('flash_custom_highlights', { clear = true }),
  desc = 'Flash - Apply custom highlights',
  callback = function()
    setupCustomHighlightGroup()
  end,
})

-- Flash-jump to a diagnostic, then run `fn` with the cursor on it
local function diag_jump(fn)
  require('flash').jump {
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
        fn()
      end)
      state:restore()
    end,
  }
end

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  init = function()
    -- Restore the built-in <CR> in the command-line window (q:), which the global flash <CR> mapping would shadow
    vim.api.nvim_create_autocmd('CmdwinEnter', {
      callback = function()
        vim.keymap.set('n', '<CR>', '<CR>', { buffer = true })
      end,
    })
  end,
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
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Jump - To label' },
    { 'S', mode = { 'o' }, function() require('flash').remote() end, desc = 'Jump - Remote action' },
    { 'S', mode = { 'n' }, function() require("flash").jump({continue = true}) end, desc = 'Jump - Continue last jump' },
    { '<leader>S', mode = { 'n', 'x', 'o' }, function() require('flash').jump { search = { mode = 'search', max_length = 0 }, label = { after = { 0, 0 } }, pattern = '^' } end, desc = 'Jump - To line' },
    { '<CR>', mode = { 'n' }, function()
        require("flash").treesitter({
          actions = {
            ["<CR>"] = "next",
            ["<S-CR>"] = "prev"
          }
        })
      end, desc = "Jump - Select treesitter node (repeat to grow)"
    },
    { '<leader><CR>', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter_search() end, desc = 'Jump - Treesitter search' },

    { '<leader>xF', mode = { 'n', 'x' }, function()
        diag_jump(function() vim.diagnostic.open_float({source = true, border="rounded"}) end)
      end, desc = 'Diagnostics - Jump to one and show float' },
    { '<leader>A', mode = { 'n', 'x' }, function() diag_jump(vim.lsp.buf.code_action) end, desc = 'Code - Action at a jumped-to diagnostic' },
    { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Jump - Toggle flash in search' },
  },
}
