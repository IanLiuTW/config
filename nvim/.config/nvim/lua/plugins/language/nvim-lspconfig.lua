return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
  },
  config = function()
    -- LSP Attach configuration
    local function setup_lsp_keymaps(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end
      -- Navigation
      map('<leader>D', require('telescope.builtin').lsp_definitions, 'Goto [D]efinition')
      map('<leader>dd', require('telescope.builtin').lsp_type_definitions, 'Goto Type [D]efinition')
      map('<leader>dD', vim.lsp.buf.declaration, 'Goto [D]eclaration')
      map('<leader>di', require('telescope.builtin').lsp_implementations, 'Goto [I]mplementation')
      -- Search and References
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Search Document Symbols')
      map('<leader>dS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Search Workspace Symbols')
      map('<leader>dr', require('telescope.builtin').lsp_references, 'Find References')
      -- Code Actions and Help
      map('<leader>a', vim.lsp.buf.code_action, 'Code Action')
      map('S', vim.lsp.buf.signature_help, 'Signature Help')
      -- Information
      map('<Leader>,L', '<cmd>LspInfo<cr>', 'LSP Info')
      -- Inlay hints toggle
      if client and client.supports_method 'textDocument/inlayHint' then
        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        map('<leader>,h', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, 'Toggle Inlay Hints')
      end

      -- Setup document highlighting
      if client and client.supports_method 'textDocument/documentHighlight' then
        local highlight_group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
        -- Document highlight events
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        })
        -- Cleanup on LSP detach
        vim.api.nvim_create_autocmd('LspDetach', {
          buffer = event.buf,
          callback = function()
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = highlight_group, buffer = event.buf }
          end,
        })
      end
    end

    -- Server configurations
    local servers = {
      -- pyright = {
      --   settings = {
      --     pyright = {
      --       -- Using Ruff's import organizer
      --       disableOrganizeImports = true,
      --     },
      --     python = {
      --       analysis = {
      --         -- Ignore all files for analysis to exclusively use Ruff for linting
      --         ignore = { '*' },
      --       },
      --     },
      --   },
      -- },
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'standard',
            },
          },
        },
      },
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = { command = 'clippy' },
            diagnostics = { experimental = { enable = true } },
            inlayHints = {
              enable = true,
              showParameterNames = true,
              parameterHintsPrefix = '<- ',
              otherHintsPrefix = '=> ',
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = { disable = { 'missing-fields' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            doc = {
              privateName = { '^_' },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
            },
          },
        },
      },
      nil_ls = {
        settings = {
          ['nil'] = {
            formatting = {
              command = { 'nixpkgs-fmt' }, -- Use nixpkgs-fmt for formatting
            },
            nix = {
              maxMemoryMB = 2048, -- Increase memory limit if needed
              flake = {
                autoEvalInputs = true, -- Auto-evaluate flake inputs
              },
            },
            diagnostics = {
              excludedFiles = {},
            },
          },
        },
      },
    }

    -- Mason setup
    require('mason').setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    -- Ensure tools are installed
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      'stylua',
      'prettier',
    })
    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
    }
    -- Configure LSP servers
    local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- Set up LSP attach event
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
      callback = setup_lsp_keymaps,
    })
  end,
}
