return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  keys = {
    { '<leader>v', '<cmd>RenderMarkdown toggle<cr>', desc = 'Render Markdown - Toggle Markview' },
    { '<leader>V', '<cmd>RenderMarkdown debug<cr>', desc = 'Render Markdown - Toggle Markview' },
  },
  opts = {
    enabled = true,
    file_types = { 'markdown', 'Avante' },
  },
  ft = { 'markdown', 'Avante' },
}
