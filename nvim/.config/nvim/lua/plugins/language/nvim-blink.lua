return {
  'saghen/blink.cmp',
  lazy = false,
  dependencies = 'rafamadriz/friendly-snippets',
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
          border = 'shadow',
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
                return ctx.idx <= 10 and ctx.idx % 10 .. ' ' or nil
              end,
              highlight = 'Orange',
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
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        snippets = {
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath 'config' .. '/snippets' },
          },
        },
      },
    },

    signature = {
      enabled = false,
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
  },

  opts_extend = { 'sources.default' },
}
