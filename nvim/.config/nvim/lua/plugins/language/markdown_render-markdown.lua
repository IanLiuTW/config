return {
  'MeanderingProgrammer/render-markdown.nvim',
  lazy = true,
  ft = { 'markdown' },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  keys = {
    { '<leader>ur', '<cmd>RenderMarkdown toggle<cr>', desc = 'Toggle Render markdown' },
    { '<leader>,r', '<cmd>RenderMarkdown debug<cr>', desc = 'Tools - Render-markdown debug' },
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown' },
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
