return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:►]]

    local ftMap = {
      vim = 'indent',
      python = { 'indent' },
      git = '',
    }
    require('ufo').setup {
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
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
          scrollU = '<C-b>',
          scrollD = '<C-f>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
      provider_selector = function(bufnr, filetype, buftype)
        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        return ftMap[filetype]

        -- refer to ./doc/example.lua for detail
      end,
    }

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, {desc = 'ufo - Open All Folds'})
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, {desc = 'ufo - Close All Folds'})
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, {desc = 'ufo - Open Folds Except Kinds'})
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, {desc = 'ufo - Close Folds With'})
    vim.keymap.set('n', '<Tab>', 'za', {desc = 'Toggle Fold'})
    vim.keymap.set('n', '<S-Tab>', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, {desc = 'ufo - Peek Folded'})
  end,
}
