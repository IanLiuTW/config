vim.api.nvim_create_autocmd('Colorscheme', {
  group = vim.api.nvim_create_augroup('update_config_custom_highlights', { clear = true }),
  callback = function()
    -- 1. Define your overrides in a data structure.
    -- Don't mix logic with data.
    local overrides = {
      -- Kept from your original config
      WinSeparator = { fg = '#b3b3b3', bold = true },

      -- Floating windows: Transparent backgrounds
      NormalFloat = { bg = 'none' },
      FloatBorder = { bg = 'none' },
      FloatTitle = { bg = 'none' },

      -- Diff highlights (Hardcoded hex is safe here)
      DiffAdd = { bg = '#2b3328' },
      DiffChange = { bg = '#252535' },
      DiffDelete = { fg = '#c34043', bg = '#43242b' },
      DiffText = { bg = '#49443c' },
    }

    -- 2. Apply the highlights in a single, clean loop.
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
      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
      on_colors = function(colors)
        -- colors.hint = colors.orange
        colors.error = '#ff0000'
      end,
      on_highlights = function(hl, c)
        hl.DiagnosticUnderlineError = {
          bg = '#2d202a',
          undercurl = true,
        }
        hl.DiagnosticUnderlineWarn = {
          bg = '#2e2a2d',
          undercurl = true,
        }
      end,
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
      }
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    opts = {
      styles = {
        transparency = true,
      },
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

          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          -- Diff highlights
          DiffAdd = { bg = '#2b3328' },
          DiffChange = { bg = '#252535' },
          DiffDelete = { fg = '#c34043', bg = '#43242b' },
          DiffText = { bg = '#49443c' },
        }
      end,
    },
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_foreground = 'mix'
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_better_performance = true
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      vim.g.gruvbox_material_current_word = 'grey background'
      vim.g.gruvbox_material_inlay_hints_background = 'dimmed'
      -- vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
  },
  {
    'vague2k/vague.nvim',
    config = function()
      require('vague').setup {
        transparent = true,
        style = {
          comments = 'italic',
          keywords = 'italic',
          functions = 'bold',
          sidebars = 'dark',
          floats = 'dark',
        },
      }
    end,
  },
}
