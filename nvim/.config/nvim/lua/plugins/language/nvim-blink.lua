return {
  'saghen/blink.cmp',
  lazy = false,
  dependencies = {
    'Kaiser-Yang/blink-cmp-avante',
    'rafamadriz/friendly-snippets',
  },
  version = 'v0.*',
  opts = {
    keymap = {
      -- ['<CR>'] = { 'select_and_accept', 'fallback' },
      ['<C-Y>'] = { 'select_and_accept', 'fallback' },
      ['<C-E>'] = { 'hide', 'fallback' },
      ['<C-N>'] = { 'select_next', 'fallback' },
      ['<C-P>'] = { 'select_prev', 'fallback' },
      ['<C-F>'] = { 'scroll_documentation_down' },
      ['<C-B>'] = { 'scroll_documentation_up' },
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ['<C-1>'] = {
        function(cmp)
          cmp.accept { index = 1 }
        end,
      },
      ['<C-2>'] = {
        function(cmp)
          cmp.accept { index = 2 }
        end,
      },
      ['<C-3>'] = {
        function(cmp)
          cmp.accept { index = 3 }
        end,
      },
      ['<C-4>'] = {
        function(cmp)
          cmp.accept { index = 4 }
        end,
      },
      ['<C-5>'] = {
        function(cmp)
          cmp.accept { index = 5 }
        end,
      },
      ['<C-6>'] = {
        function(cmp)
          cmp.accept { index = 6 }
        end,
      },
      ['<C-7>'] = {
        function(cmp)
          cmp.accept { index = 7 }
        end,
      },
      ['<C-8>'] = {
        function(cmp)
          cmp.accept { index = 8 }
        end,
      },
      ['<C-9>'] = {
        function(cmp)
          cmp.accept { index = 9 }
        end,
      },
      ['<C-0>'] = {
        function(cmp)
          cmp.accept { index = 10 }
        end,
      },
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = 'rounded',
          min_width = 30,
          max_height = 30,
        },
      },
      menu = {
        max_height = 10,
        border = 'shadow',
        draw = {
          columns = { { 'item_idx' }, { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', gap = 1 }, { 'source_name' } },
          components = {
            item_idx = {
              text = function(ctx)
                return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx)
              end,
              highlight = 'SnacksDashboardKey',
            },
            source_name = {
              width = { max = 10 },
              text = function(ctx)
                return '[' .. ctx.source_name .. ']'
              end,
              highlight = 'Comment',
            },
          },
        },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
    },

    sources = {
      default = function(ctx)
        local success, node = pcall(vim.treesitter.get_node)
        if vim.bo.filetype == 'lua' then
          return { 'avante', 'lsp', 'path' }
        elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
          return { 'buffer' }
        else
          return { 'avante', 'lsp', 'path', 'snippets', 'buffer' }
        end
      end,
      providers = {
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = {
            -- options for blink-cmp-avante
          },
        },
      },
    },

    signature = {
      enabled = false,
      window = { border = 'single' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    cmdline = {
      completion = {
        menu = {
          auto_show = true,
          -- auto_show = function(ctx)
          --   return vim.fn.getcmdtype() == ':'
          -- end,
        },
      },
    },
  },

  opts_extend = { 'sources.default' },
}
