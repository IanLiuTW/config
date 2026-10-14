-- Fold providers per filetype: { main, fallback }. Unlisted filetypes use ufo's default { 'lsp', 'indent' }.
local providers = {
  vim = 'indent',
  python = 'indent',
  git = '',
}

-- stylua: ignore
return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  event = 'BufReadPost',
  init = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99 -- ufo needs a high foldlevel to manage folds itself
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  keys = {
    { 'zR',      function() require('ufo').openAllFolds() end,               desc = 'ufo - Open All Folds' },
    { 'zM',      function() require('ufo').closeAllFolds() end,              desc = 'ufo - Close All Folds' },
    { 'zr',      function() require('ufo').openFoldsExceptKinds() end,       desc = 'ufo - Open Folds Except Kinds' },
    { 'zm',      function() require('ufo').closeFoldsWith() end,             desc = 'ufo - Close Folds With' },
    { '<Tab>',   'za',                                                       desc = 'Toggle Fold' },
    { '<S-Tab>', function() require('ufo').peekFoldedLinesUnderCursor() end, desc = 'ufo - Peek Folded' },
  },
  opts = {
    open_fold_hl_timeout = 200,
    close_fold_kinds_for_ft = {
      default = { 'comment' },
      json = { 'array' },
      c = { 'comment', 'region' },
    },
    preview = {
      win_config = {
        border = { '', '─', '', '', '', '─', '', '' },
        winhighlight = 'Normal:Folded',
        winblend = 0,
      },
      mappings = {
        scrollU = '<C-u>',
        scrollD = '<C-d>',
        jumpTop = 'gg',
        jumpBot = 'G',
      },
    },
    provider_selector = function(_, filetype)
      return providers[filetype]
    end,
  },
}
