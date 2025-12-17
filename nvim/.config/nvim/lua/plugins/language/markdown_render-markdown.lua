return {
  'MeanderingProgrammer/render-markdown.nvim',
  lazy = true,
  ft = { 'markdown', 'Avante', 'md' },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  keys = {
    { '<leader>v', '<cmd>RenderMarkdown toggle<cr>', desc = 'Render Markdown - Toggle Markview' },
    { '<leader>V', '<cmd>RenderMarkdown debug<cr>', desc = 'Render Markdown - Toggle Markview' },
  },
  opts = {
    file_types = { 'markdown', 'Avante', 'md' },
    render_modes = { 'n', 'no', 'c', 't', 'i', 'ic' },
    code = {
      sign = false,
      border = 'thin',
      position = 'right',
      width = 'block',
      above = '▁',
      below = '▔',
      language_left = '█',
      language_right = '█',
      language_border = '▁',
      left_pad = 1,
      right_pad = 1,
    },
    heading = {
      sign = false,
      width = 'block',
      backgrounds = {
        'MiniStatusLineModeVisual',
        'MiniStatusLineModeCommand',
        'MiniStatusLineModeReplace',
        'MiniStatusLineModeNormal',
        'MiniStatusLineModeOther',
        'MiniStatusLineModeInsert',
      },
      left_pad = 1,
      right_pad = 0,
      position = 'right',
      icons = function(ctx)
        return (''):rep(ctx.level) .. ''
      end,
    },
  },
}
