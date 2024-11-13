return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Group formatting-related keymaps together
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          lsp_fallback = true,
          timeout_ms = 500, -- Add timeout for better responsiveness
        }
      end,
      mode = 'n',
      desc = 'Buffer - [F]ormat',
    },
    {
      '<leader>zF',
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
        'ruff_fix', -- Fix auto-fixable lint errors
        'ruff_format', -- Run Ruff formatter
        'ruff_organize_imports', -- Organize imports
      },
      rust = {
        'rustfmt',
        lsp_format = 'fallback',
      },
      -- Web development formatters
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
      ['*'] = { 'codespell' },
      ['_'] = { 'trim_whitespace' },
    },
    -- Default formatting options
    default_format_opts = {
      lsp_fallback = 'fallback',
      async = true,
      quiet = false,
    },
  },
}
