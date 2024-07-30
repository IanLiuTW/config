return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
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
    priority = 1000,
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
    priority = 1000,
    opts = {
      transparent = true,
      functionStyle = { italic = true, bold = true },
    },
    init = function()
      local toggleterm = require 'toggleterm'
      toggleterm.setup {
        shade_terminals = false,
        highlights = {
          Normal = {
            guibg = '#000000'
          },
        },
      }
    end,
  },
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('vague').setup {
        transparent = true,
        style = {
          keywords = 'italic',
        },
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = 'dark',
        floats = 'dark',
      },
      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = '#ff0000'
      end,
      on_highlights = function(hl, c)
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
    init = function()
      -- A fix to make toggleterm's background to be dark
      local colors = require('tokyonight.colors').setup()
      local toggleterm = require 'toggleterm'
      toggleterm.setup {
        shade_terminals = false,
        highlights = {
          Normal = {
            guibg = colors.bg_dark,
          },
        },
      }
    end,
  },
}
