return {
  'hedyhli/outline.nvim',
  lazy = true,
  dependencies = {
    'onsails/lspkind.nvim',
  },
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    { '<leader>co', '<cmd>Outline!<CR>', desc = 'Code - Outline (keep focus)' },
    { '<leader>cO', '<cmd>Outline<CR>', desc = 'Code - Outline (jump into it)' },
  },
  opts = {
    outline_items = {
      show_symbol_lineno = true,
    },
    preview_window = {
      auto_preview = false,
    },
    symbols = { icon_source = 'lspkind' },
    keymaps = {
      show_help = '?',
      close = { '<Esc>', 'q' },
      goto_location = '<C-y>',
      goto_and_close = '<CR>',
      peek_location = ',',
      restore_location = '.',
      hover_symbol = 'K',
      toggle_preview = '<S-Tab>',
      rename_symbol = 'r',
      code_actions = 'a',
      -- Fold actions collapse outline nodes, not code folds
      fold = 'h',
      unfold = 'l',
      fold_toggle = '<Space>',
      fold_toggle_all = '<S-Space>',
      fold_all = 'z',
      unfold_all = 'Z',
      fold_reset = '=',
      up_and_jump = '<C-P>',
      down_and_jump = '<C-N>',
    },
  },
}
