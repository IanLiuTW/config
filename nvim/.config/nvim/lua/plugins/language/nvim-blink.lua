return {
  'saghen/blink.cmp',
  lazy = false,
  dependencies = {
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
    },

    highlight = {
      use_nvim_cmp_as_default = true,
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        border = 'shadow',
        min_width = 20,
        max_width = 45, -- smaller, due to https://github.com/Saghen/blink.cmp/issues/194
        max_height = 20,
      },
      menu = {
        border = 'shadow',
        draw = {
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', gap = 1 } },
        },
      },
    },

    signature = {
      enabled = false,
    },

    sources = {
      completion = {
        enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      providers = {
        snippets = {
          opts = {
            search_paths = { vim.fn.stdpath 'config' .. '/snippets' },
          },
        },
        path = {
          -- opts = { get_cwd = vim.uv.cwd },
        },
        buffer = {
          fallback_for = {}, -- disable being fallback for LSP
          max_items = 4,
          min_keyword_length = 4,
          score_offset = -3,
        },
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'normal',
      kind_icons = {
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',
        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',
        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',
        Keyword = '󰻾',
        Constant = '󰏿',
        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },
  },

  opts_extend = { 'sources.completion.enabled_providers' },
}
