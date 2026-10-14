return
{
  'alexpasmantier/krust.nvim',
  ft = 'rust',
  opts = {
    keymap = '<leader>xr', -- Rust buffers only: cargo-style diagnostic float
    float_win = {
      border = 'rounded',
      auto_focus = false,
    },
  },
}
