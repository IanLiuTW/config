return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'rshkarin/mason-nvim-lint',
  },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      python = { 'flake8' },
      json = { 'jsonlint' },
      yaml = { 'yamllint' },
      -- markdown = { 'markdownlint' },
    }

    table.insert(lint.linters.markdownlint.args, '--disable')
    table.insert(lint.linters.markdownlint.args, 'MD013')
    table.insert(lint.linters.flake8.args, '--ignore=E501,W503')

    -- Configure codespell to show as hints rather than warnings
    lint.linters.codespell = require('lint.util').wrap(lint.linters.codespell, function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
      return diagnostic
    end)

    -- Debounced linting for better performance
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Debounce linting
        vim.defer_fn(function()
          lint.try_lint()
          lint.try_lint 'codespell'
        end, 100)
      end,
    })

    require('mason-nvim-lint').setup()
  end,
}
