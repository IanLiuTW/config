vim.api.nvim_create_autocmd('Colorscheme', {
  group = vim.api.nvim_create_augroup('update_config_custom_highlights', { clear = true }),
  callback = function()
    local function get_hl(name)
      return vim.api.nvim_get_hl(0, { name = name, link = false })
    end

    local function color(name, attr)
      local hl = get_hl(name)
      return hl and hl[attr] and string.format('#%06x', hl[attr]) or 'NONE'
    end

    local c = {
      accent = color('Special', 'fg'),
      keyword = color('Keyword', 'fg'),
      markup = color('String', 'fg'),
      entity = color('Constant', 'fg'),
      regexp = color('SpecialChar', 'fg'),
      string = color('String', 'fg'),
      tag = color('Function', 'fg'),
      constant = color('Constant', 'fg'),
      vcs_added = color('DiffAdd', 'bg'),
      selection_bg = color('Visual', 'bg'),
      selection_inactive = color('CursorLine', 'bg'),
    }

    local overrides = {
      -- Windows and floats
      WinSeparator = { fg = '#b3b3b3', bold = true },
      NormalFloat = { bg = 'none' },
      FloatBorder = { bg = 'none' },
      FloatTitle = { bg = 'none' },

      -- render-markdown, colored from the active theme
      RenderMarkdownCode = { bg = c.selection_inactive },
      RenderMarkdownCodeBorder = { bg = c.selection_bg },
      RenderMarkdownCodeInline = { fg = c.tag, bg = c.selection_inactive },
      RenderMarkdownH1 = { fg = c.accent },
      RenderMarkdownH2 = { fg = c.keyword },
      RenderMarkdownH3 = { fg = c.markup },
      RenderMarkdownH4 = { fg = c.entity },
      RenderMarkdownH5 = { fg = c.regexp },
      RenderMarkdownH6 = { fg = c.string },

      -- Treesitter markup, colored from the active theme
      ['@markup.heading'] = { fg = c.keyword, bold = true },
      ['@markup.heading.1'] = { fg = c.accent, bold = true },
      ['@markup.heading.2'] = { fg = c.keyword, bold = true },
      ['@markup.heading.3'] = { fg = c.markup, bold = true },
      ['@markup.heading.4'] = { fg = c.entity, bold = true },
      ['@markup.heading.5'] = { fg = c.regexp, bold = true },
      ['@markup.heading.6'] = { fg = c.string, bold = true },
      ['@markup.strong'] = { fg = c.keyword, bold = true },
      ['@markup.italic'] = { fg = c.keyword, italic = true },
      ['@markup.list'] = { fg = c.vcs_added },
      ['@markup.raw'] = { fg = c.tag, bg = c.selection_inactive },
      ['@markup.quote'] = { fg = c.constant, italic = true },
    }

    -- These hexes are tuned for a dark background; on a light colorscheme,
    -- keep the theme's own diff and diagnostic colors instead
    if vim.o.background == 'dark' then
      overrides = vim.tbl_extend('force', overrides, {
        -- Diff, fixed Kanagawa-style colors
        DiffAdd = { bg = '#2b3328' },
        DiffChange = { bg = '#252535' },
        DiffDelete = { fg = '#c34043', bg = '#43242b' },
        DiffText = { bg = '#49443c' },

        -- LSP and diagnostics
        LspInlayHint = { bg = '#212121', fg = '#664E39' },
        DiagnosticUnnecessary = { fg = '#969696' },
        DiagnosticUnderlineError = { undercurl = true, sp = '#ff0000', bg = '#2d202a' },
        DiagnosticUnderlineWarn = { undercurl = true, sp = '#e0af68', bg = '#2e2a2d' },
        DiagnosticUnderlineHint = { undercurl = true, sp = '#1abc9c', bg = '#102b2a' },
        DiagnosticUnderlineInfo = { undercurl = true, sp = '#0db9d7', bg = '#192b38' },
      })
    end

    for group, opts in pairs(overrides) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end,
})

return {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      style = 'storm',
      transparent = true,
      terminal_colors = true,
      lualine_bold = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        sidebars = 'dark',
        floats = 'dark',
      },
      on_colors = function(colors)
        colors.error = '#ff0000'
      end,
    },
  },
  {
    'serhez/teide.nvim',
    lazy = true,
    opts = {
      style = 'dark',
      transparent = true,
      terminal_colors = true,
      lualine_bold = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        sidebars = 'dark',
        floats = 'dark',
      },
      on_colors = function(colors)
        colors.error = '#ff0000'
      end,
    },
  },
}
