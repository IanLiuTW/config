return {
  {
    -- Installs the linters below; runs after startup since linters resolve through PATH
    'rshkarin/mason-nvim-lint',
    event = 'VeryLazy',
    dependencies = { 'mfussenegger/nvim-lint' },
    config = function()
      require('mason-nvim-lint').setup()
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        python = { 'ruff' },
        json = { 'jsonlint' },
        yaml = { 'yamllint' },
      }

      -- Show codespell findings as hints, not warnings
      lint.linters.codespell = require('lint.util').wrap(lint.linters.codespell, function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.HINT
        return diagnostic
      end)

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function(ev)
          vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(ev.buf) or vim.bo[ev.buf].buftype ~= '' then
              return
            end
            vim.api.nvim_buf_call(ev.buf, function()
              lint.try_lint()
              lint.try_lint 'codespell'
            end)
          end, 100)
        end,
      })
    end,
  },
}
