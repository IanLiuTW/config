return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = { -- Example mapping to toggle outline
    { '<leader>o', '<cmd>Outline!<CR>', desc = '[O]utline Toggle w/o Switching)' },
    { '<leader>O', '<cmd>Outline<CR>', desc = '[O]utline Toggle' },
  },
  opts = {
    symbols = { icon_source = 'lspkind' },
    keymaps = {
      show_help = '?',
      close = { '<Esc>', 'q' },
      -- Jump to symbol under cursor.
      -- It can auto close the outline window when triggered, see
      -- 'auto_close' option above.
      goto_location = '<Cr>',
      -- Jump to symbol under cursor but keep focus on outline window.
      peek_location = '<C-h>',
      -- Visit location in code and close outline immediately
      goto_and_close = '<S-Cr>',
      -- Change cursor position of outline window to match current location in code.
      -- 'Opposite' of goto/peek_location.
      restore_location = '<C-l>',
      -- Open LSP/provider-dependent symbol hover information
      hover_symbol = 'gd',
      -- Preview location code of the symbol under cursor
      toggle_preview = '<space>',
      rename_symbol = 'r',
      code_actions = 'a',
      -- These fold actions are collapsing tree nodes, not code folding
      fold = 'h',
      unfold = 'l',
      fold_toggle = '<Tab>',
      -- Toggle folds for all nodes.
      -- If at least one node is folded, this action will fold all nodes.
      -- If all nodes are folded, this action will unfold all nodes.
      fold_toggle_all = '<S-Tab>',
      fold_all = 'z',
      unfold_all = 'Z',
      fold_reset = 'R',
      -- Move down/up by one line and peek_location immediately.
      -- You can also use outline_window.auto_jump=true to do this for any
      -- j/k/<down>/<up>.
      down_and_jump = '<C-j>',
      up_and_jump = '<C-k>',
    },
  },
}
