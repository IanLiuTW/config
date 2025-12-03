-- TODO: Finish the setup: https://github.com/mrcjkb/rustaceanvim

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
    float_win_config = {
      border = 'rounded',
    },
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      local bufnr = vim.api.nvim_get_current_buf()
      -- vim.keymap.set({ 'n', 'x' }, '<leader>a', function()
      --   vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping or vim.lsp.buf.codeAction() if you don't want grouping.
      -- end, { silent = true, buffer = bufnr, desc = 'LSP - Rustaceanvim - Code Action' })
      vim.keymap.set('n', 'K', function() -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
        vim.cmd.RustLsp { 'hover', 'actions' }
      end, { silent = true, buffer = bufnr, desc = 'LSP - Rustaceanvim - Hover Actions' })

      vim.keymap.set('n', '<leader>dK', function()
        vim.cmd.RustLsp { 'moveItem', 'up' }
      end, { silent = true, buffer = bufnr, desc = 'LSP - Rustaceanvim - Move Item Up' })
      vim.keymap.set('n', '<leader>dJ', function()
        vim.cmd.RustLsp { 'moveItem', 'down' }
      end, { silent = true, buffer = bufnr, desc = 'LSP - Rustaceanvim - Move Item Down' })

      vim.keymap.set('n', '<leader>e<space>', function()
        vim.cmd.RustLsp 'debuggables'
      end, { silent = true, buffer = bufnr, desc = 'Rustaceanvim - Debuggables List' })
      vim.keymap.set('n', '<leader>er', function()
        vim.cmd.RustLsp 'debug'
      end, { silent = true, buffer = bufnr, desc = 'Rustaceanvim - Debug' })
      vim.keymap.set('n', '<leader>eR', function()
        vim.cmd.RustLsp { 'debuggables', bang = true }
      end, { silent = true, buffer = bufnr, desc = 'Rustaceanvim - Debug Last' })

      vim.keymap.set('n', '<leader>r<space>', function()
        vim.cmd.RustLsp 'runnables'
      end, { silent = true, buffer = bufnr, desc = 'Rustaceanvim - Runnables List' })
      vim.keymap.set('n', '<leader>rr', function()
        vim.cmd.RustLsp 'run'
      end, { silent = true, buffer = bufnr, desc = 'Rustaceanvim - Run' })
      vim.keymap.set('n', '<leader>rR', function()
        vim.cmd.RustLsp { 'runnables', bang = true }
      end, { silent = true, buffer = bufnr, desc = 'Rustaceanvim - Run Last' })

      vim.keymap.set('n', '<leader>t<space>', function()
        vim.cmd.RustLsp 'testables'
      end, { silent = true, buffer = bufnr, desc = 'Rustaceanvim - Testables List' })
      vim.keymap.set('n', '<leader>tR', function()
        vim.cmd.RustLsp { 'testables', bang = true }
      end, { silent = true, buffer = bufnr, desc = 'Rustaceanvim - Test Last' })
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        checkOnSave = { command = 'clippy' },
        diagnostics = { experimental = { enable = true } },
        inlayHints = {
          enable = true,
          showParameterNames = true,
          -- parameterHintsPrefix = '<- ',
          -- otherHintsPrefix = '=> ',
        },
      },
    },
  },
  -- DAP configuration
  dap = {},
}
return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
}
