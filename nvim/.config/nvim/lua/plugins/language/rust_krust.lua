return
{
  'alexpasmantier/krust.nvim',
  ft = 'rust',
  opts = {
    keymap = '<leader>xr', -- Rust buffers only: cargo-style diagnostic float
    float_win = {
      border = 'rounded', -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
      auto_focus = false, -- Auto-focus float (default: false)
    },
  },
}
