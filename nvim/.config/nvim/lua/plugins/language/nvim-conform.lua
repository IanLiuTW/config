return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format()
      end,
      mode = 'n',
      desc = 'Code - Format',
    },
    {
      '<leader>,f',
      '<Cmd>ConformInfo<CR>',
      desc = 'Tools - Formatter info',
    },
  },
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = {
        'ruff_organize_imports',
        'ruff_format',
      },
      rust = {
        'rustfmt',
        lsp_format = 'fallback',
      },
      javascript = {
        'prettierd',
        'prettier',
        stop_after_first = true,
      },
      typescript = {
        'prettierd',
        'prettier',
        stop_after_first = true,
      },
      json = { 'prettier' },
      markdown = { 'prettier' },
      nix = { 'nixfmt' },

      -- `_` applies to filetypes with no formatter listed above
      ['_'] = { 'trim_whitespace' },
    },
    formatters = {
      stylua = {
        append_args = {
          '--indent-type',
          'Spaces',
        },
      },
    },
    default_format_opts = {
      lsp_format = 'fallback',
      async = true,
      quiet = false,
      timeout_ms = 500,
    },
  },
}
