vim.api.nvim_create_autocmd('Colorscheme', {
  group = vim.api.nvim_create_augroup('udpate_config_custom_highlights', {}),
  callback = function()
    vim.api.nvim_set_hl(0, 'LspInlayHint', { bg = 'Black' })

    -- vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', {
    --   undercurl = true, -- or underline = true if you prefer
    --   sp = 'Yellow', -- underline color
    --   bg = 'LightYellow', -- background color
    -- })
    --
    -- vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', {
    --   undercurl = true,
    --   sp = 'Red', -- underline color
    --   bg = 'LightRad', -- light red/pink background
    -- })
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

        local prompt = '#2d3149'
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
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
      functionStyle = { italic = true, bold = true },
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
      vim.cmd.colorscheme 'gruvbox-material'
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
