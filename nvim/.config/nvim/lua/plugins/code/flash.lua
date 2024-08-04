local function setupCustomHighlightGroup()
  vim.api.nvim_command 'hi clear FlashMatch'
  vim.api.nvim_command 'hi clear FlashCurrent'
  vim.api.nvim_command 'hi clear FlashLabel'

  vim.api.nvim_command 'hi FlashMatch guifg=#b8b5ff guibg=#4a47a3'
  vim.api.nvim_command 'hi FlashCurrent guifg=#d0e8f2 guibg=#456268'
  vim.api.nvim_command 'hi FlashLabel cterm=bold gui=bold guifg=#c0caf5 guibg=#ff007c'
end

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = '',
  callback = function()
    setupCustomHighlightGroup()
  end,
})

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
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
  -- stylua: ignore
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
