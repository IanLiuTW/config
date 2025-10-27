return {
  'copilotlsp-nvim/copilot-lsp',
  init = function()
    vim.g.copilot_nes_debounce = 500
    vim.lsp.enable 'copilot_ls'
  end,
  opts = {
    nes = {
      move_count_threshold = 1,
    },
  },
}
