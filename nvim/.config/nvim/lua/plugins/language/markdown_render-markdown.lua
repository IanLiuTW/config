return {
  'MeanderingProgrammer/render-markdown.nvim',
  lazy = true,
  -- With a cmd trigger the plugin does not attach on load with its default config
  cmd = 'RenderMarkdown',
  -- Loaded one tick after the first markdown FileType, so opening markdown does not wait
  -- on rendering: the first frame shows plain text, then the rendered view
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      once = true,
      callback = function()
        vim.schedule(function()
          require('lazy').load { plugins = { 'render-markdown.nvim' } }
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == 'markdown' then
              vim.api.nvim_exec_autocmds('FileType', { group = 'RenderMarkdown', buffer = buf })
            end
          end
        end)
      end,
    })
  end,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
