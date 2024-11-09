return { -- Autoformat
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
      desc = 'Buffer - [F]ormat',
    },
    { '<leader>zF', '<Cmd>ConformInfo<CR>', desc = 'Conform - Show [F]ormatter Info' },
  },
  opts = {
    notify_on_error = true,
    format_on_save = false,
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true }
    --   return {
    --     timeout_ms = 500,
    --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --   }
    -- end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      markdown = { 'prettier' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettier' },
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
      ['_'] = { 'trim_whitespace' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
  },
}
