return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  -- use a release tag to download pre-built binaries
  version = 'v0.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
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

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
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
  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.completion.enabled_providers' },
}
