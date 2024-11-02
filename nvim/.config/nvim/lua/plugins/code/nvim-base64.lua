return {
  "deponian/nvim-base64",
  version = "*",
  lazy = true,
  keys = {
    { "<Leader>cb", "<Plug>(FromBase64)", mode = "x" , desc = "Base64 decode" },
    { "<Leader>cB", "<Plug>(ToBase64)", mode = "x", desc = "Base64 encode" },
  },
  config = function()
    require("nvim-base64").setup()
  end,
}
