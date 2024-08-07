return {
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
      -- local colors = require('tokyonight.colors').setup()
      local toggleterm = require 'toggleterm'
      toggleterm.setup {
        shade_terminals = false,
        highlights = {
          Normal = {
            guibg = '#1c1c1c',
          },
        },
      }
    end,
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
    'ellisonleao/gruvbox.nvim',
    opts = {
      transparent_mode = true,
    },
  },
  {
    'EdenEast/nightfox.nvim',
    opts = {
      options = {
        transparent = true,
        styles = { -- Style to be applied to different syntax groups
          comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
          conditionals = 'NONE',
          constants = 'bold,underline',
          functions = 'bold,italic',
          keywords = 'bold',
          numbers = 'NONE',
          operators = 'NONE',
          strings = 'NONE',
          types = 'underline',
          variables = 'NONE',
        },
      },
    },
  },
  {
    'vague2k/vague.nvim',
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
    'eldritch-theme/eldritch.nvim',
    name = 'eldritch',
    opts = {
      transparent = true,
      -- This function is found in the documentation
      on_highlights = function(highlights)
        -- nvim-spectre highlight colors
        highlights.DiffChange = { bg = '#37f499', fg = 'black' }
        highlights.DiffDelete = { bg = '#f265b5', fg = 'black' }

        -- horizontal line that goes across where cursor is
        highlights.CursorLine = { bg = '#3f404f' }
        -- highlights.Comment = { fg = "#a5afc2", italic = true }

        -- I do the line below to change the color of bold text
        highlights['@markup.strong'] = { fg = '#f265b5', bold = true }

        -- Change the spell underline color
        --
        -- Every time you change an undercurl setting here, make sure to kill the tmux
        -- session or you won't see the changes
        --
        -- For this to work in kitty, you need to add some configs to your
        -- tmux.conf file, go to that file and look for "Undercurl support"
        --
        -- You could also set these to bold or italic if you wanted, example:
        -- highlights.SpellBad = { sp = "#37f499", undercurl = true, bold = true, italic = true }
        --
        highlights.SpellBad = { sp = '#f16c75', undercurl = true, bold = true, italic = true }
        highlights.SpellCap = { sp = '#f1fc79', undercurl = true, bold = true, italic = true }
        highlights.SpellLocal = { sp = '#ebfafa', undercurl = true, bold = true, italic = true }
        highlights.SpellRare = { sp = '#a48cf2', undercurl = true, bold = true, italic = true }

        -- highlights.SpellBad = { sp = "#f16c75", undercurl = true }
        -- highlights.SpellCap = { sp = "#f16c75", undercurl = true }
        -- highlights.SpellLocal = { sp = "#f16c75", undercurl = true }
        -- highlights.SpellRare = { sp = "#f16c75", undercurl = true }

        -- My headings are this color, so this is not a good idea
        -- highlights.SpellBad = { sp = "#f16c75", undercurl = true, fg = "#37f499" }
        -- highlights.SpellCap = { sp = "#f16c75", undercurl = true, fg = "#37f499" }
        -- highlights.SpellLocal = { sp = "#f16c75", undercurl = true, fg = "#37f499" }
        -- highlights.SpellRare = { sp = "#f16c75", undercurl = true, fg = "#37f499" }

        -- These colors are used by mini-files.lua to show git changes
        highlights.MiniDiffSignAdd = { fg = '#f1fc79', bold = true }
        highlights.MiniDiffSignChange = { fg = '#37f499', bold = true }

        -- highlights.Normal = { bg = "#09090d", fg = "#ebfafa" }
      end,
      -- Overriding colors globally
      -- These colors can be found in the palette.lua file
      -- https://github.com/eldritch-theme/eldritch.nvim/blob/master/lua/eldritch/palette.lua
      on_colors = function(colors)
        -- This is in case you want to change the background color (where you type
        -- text in neovim)
        -- colors.bg = "#09090d"
        colors.comment = '#a5afc2'
      end,
    },
  },
}
