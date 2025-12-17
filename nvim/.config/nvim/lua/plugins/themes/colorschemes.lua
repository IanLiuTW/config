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
      bg                 = color('Normal', 'bg'),
      accent             = color('Special', 'fg'),      -- Teal/Blue
      keyword            = color('Keyword', 'fg'),      -- Purple/Red
      markup             = color('String', 'fg'),       -- Green
      entity             = color('Constant', 'fg'),     -- Orange
      regexp             = color('SpecialChar', 'fg'),  -- Pink/Red
      string             = color('String', 'fg'),
      tag                = color('Function', 'fg'),
      constant           = color('Constant', 'fg'),
      vcs_added          = color('DiffAdd', 'bg'),      -- Greenish
      selection_bg       = color('Visual', 'bg'),       -- Selection
      selection_inactive = color('CursorLine', 'bg'),   -- Subtle background
    }

    -- 2. Define your overrides
    local overrides = {
      -- === GUI & Windows ===
      WinSeparator = { fg = '#b3b3b3', bold = true },
      NormalFloat = { bg = 'none' },
      FloatBorder = { bg = 'none' },
      FloatTitle = { bg = 'none' },

      -- === Diff Highlights (Hardcoded Kanagawa-style) ===
      DiffAdd = { bg = '#2b3328' },
      DiffChange = { bg = '#252535' },
      DiffDelete = { fg = '#c34043', bg = '#43242b' },
      DiffText = { bg = '#49443c' },

      -- === LSP & Diagnostics ===
      LspInlayHint = { bg = '#212121', fg = '#664E39' },
      DiagnosticUnnecessary = { fg = '#969696' },
      DiagnosticUnderlineError = { undercurl = true, sp = '#ff0000', bg = '#2d202a' },
      DiagnosticUnderlineWarn = { undercurl = true, sp = '#e0af68', bg = '#2e2a2d' },
      DiagnosticUnderlineHint = { undercurl = true, sp = '#1abc9c', bg = '#102b2a' },
      DiagnosticUnderlineInfo = { undercurl = true, sp = '#0db9d7', bg = '#192b38' },

      -- === Render Markdown (Dynamic using 'c') ===
      RenderMarkdownCode             = { bg = c.selection_inactive },
      RenderMarkdownCodeBorder       = { bg = c.selection_bg },
      RenderMarkdownCodeInline       = { fg = c.tag, bg = c.selection_inactive },
      RenderMarkdownH1               = { fg = c.accent },
      RenderMarkdownH2               = { fg = c.keyword },
      RenderMarkdownH3               = { fg = c.markup },
      RenderMarkdownH4               = { fg = c.entity },
      RenderMarkdownH5               = { fg = c.regexp },
      RenderMarkdownH6               = { fg = c.string },
      RenderMarkdownH1Bg             = { fg = c.bg, bg = c.accent },
      RenderMarkdownH2Bg             = { fg = c.bg, bg = c.keyword },
      RenderMarkdownH3Bg             = { fg = c.bg, bg = c.markup },
      RenderMarkdownH4Bg             = { fg = c.bg, bg = c.entity },
      RenderMarkdownH5Bg             = { fg = c.bg, bg = c.regexp },
      RenderMarkdownH6Bg             = { fg = c.bg, bg = c.string },

      -- === TreeSitter Markup (Dynamic using 'c') ===
      ['@markup.heading']            = { fg = c.keyword, bold = true },
      ['@markup.heading.1']          = { fg = c.accent,  bold = true },
      ['@markup.heading.2']          = { fg = c.keyword, bold = true },
      ['@markup.heading.3']          = { fg = c.markup,  bold = true },
      ['@markup.heading.4']          = { fg = c.entity,  bold = true },
      ['@markup.heading.5']          = { fg = c.regexp,  bold = true },
      ['@markup.heading.6']          = { fg = c.string,  bold = true },
      ['@markup.strong']             = { fg = c.keyword, bold = true },
      ['@markup.italic']             = { fg = c.keyword, italic = true },
      ['@markup.list']               = { fg = c.vcs_added },
      ['@markup.raw']                = { fg = c.tag, bg = c.selection_inactive },
      ['@markup.quote']              = { fg = c.constant, italic = true },
    }

    -- 3. Apply all highlights
    for group, opts in pairs(overrides) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end,
})

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
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
        -- colors.hint = colors.orange
        colors.error = '#ff0000'
      end,
      on_highlights = function(hl, c) end,
    },
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    lazy = false,
    opts = {
      transparent = true,
      commentStyle = { italic = true },
      functionStyle = { bold = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = { italic = true, bold = true },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        local makeDiagnosticColor = function(color)
          local c = require 'kanagawa.lib.color'
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
          DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
    },
  },
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   lazy = false,
  --   config = function()
  --     require('catppuccin').setup {
  --       flavour = 'mocha',
  --       transparent_background = true,
  --     }
  --   end,
  -- },
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   lazy = false,
  --   opts = {
  --     styles = {
  --       transparency = true,
  --     },
  --   },
  -- },
  -- {
  --   'sainnhe/gruvbox-material',
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     vim.g.gruvbox_material_foreground = 'mix'
  --     vim.g.gruvbox_material_background = 'medium'
  --     vim.g.gruvbox_material_better_performance = true
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.g.gruvbox_material_enable_bold = true
  --     vim.g.gruvbox_material_transparent_background = 1
  --     vim.g.gruvbox_material_diagnostic_text_highlight = 1
  --     vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
  --     vim.g.gruvbox_material_current_word = 'grey background'
  --     vim.g.gruvbox_material_inlay_hints_background = 'dimmed'
  --     -- vim.cmd.colorscheme 'gruvbox-material'
  --   end,
  -- },
  -- {
  --   'EdenEast/nightfox.nvim',
  -- },
  -- {
  --   'vague2k/vague.nvim',
  --   config = function()
  --     require('vague').setup {
  --       transparent = true,
  --       style = {
  --         comments = 'italic',
  --         keywords = 'italic',
  --         functions = 'bold',
  --         sidebars = 'dark',
  --         floats = 'dark',
  --       },
  --     }
  --   end,
  -- },
}
