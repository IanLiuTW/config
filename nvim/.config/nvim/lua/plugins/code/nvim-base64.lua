return {
  "deponian/nvim-base64",
  version = "*",
  lazy = true,
  keys = {
    { "<Leader>db", "<Plug>(FromBase64)", mode = "x" , desc = "Base64 decode" },
    { "<Leader>dB", "<Plug>(ToBase64)", mode = "x", desc = "Base64 encode" },
  },
  config = function()
    require("nvim-base64").setup()
  end,
}
