return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = 'n',
      desc = 'Buffer - Format (Conform)',
    },
    {
      '<leader>,f',
      '<Cmd>ConformInfo<CR>',
      desc = 'Conform - Show [F]ormatter Info',
    },
  },
  opts = {
    notify_on_error = true,
    -- Formatter configurations by filetype
    formatters_by_ft = {
      lua = { 'stylua' },
      python = {
        'black',
        'isort',
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
      nix = { 'nixpkgs_fmt' },

      -- Global formatters
      -- ['*'] = { 'codespell' }, -- this auto fixes spelling mistakes
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
    -- Default formatting options
    default_format_opts = {
      lsp_fallback = true,
      async = true,
      quiet = false,
      timeout_ms = 500, -- Add timeout for better responsiveness
    },
  },
}
