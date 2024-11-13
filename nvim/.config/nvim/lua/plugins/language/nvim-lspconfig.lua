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
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Keybinding groups by functionality
      -- Navigation
      map('<leader>D', require('telescope.builtin').lsp_definitions, 'Goto [D]efinition')
      map('<leader>cd', require('telescope.builtin').lsp_type_definitions, 'Goto Type [D]efinition')
      map('<leader>cD', vim.lsp.buf.declaration, 'Goto [D]eclaration')
      map('<leader>ci', require('telescope.builtin').lsp_implementations, 'Goto [I]mplementation')

      -- Search and References
      map('<leader>cs', require('telescope.builtin').lsp_document_symbols, 'Search Document Symbols')
      map('<leader>cS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Search Workspace Symbols')
      map('<leader>cr', require('telescope.builtin').lsp_references, 'Find References')

      -- Code Actions and Help
      map('<leader>a', vim.lsp.buf.code_action, 'Code Action')
      map('S', vim.lsp.buf.signature_help, 'Signature Help')

      map('<Leader>zL', '<cmd>LspInfo<cr>', 'LSP Info')

      -- Setup document highlighting
      local client = vim.lsp.get_client_by_id(event.data.client_id)
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

      -- Inlay hints toggle
      if client and client.supports_method 'textDocument/inlayHint' then
        map('<leader>ch', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, 'Toggle Inlay Hints')
      end
    end

    -- Set up LSP servers
    local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

    -- Server configurations
    local servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = 'basic',
              diagnosticMode = 'workspace',
              -- Exclude files that will be handled by ruff
              ignore = { '**/node_modules', '**/__pycache__' },
            },
          },
        },
      },
      -- ruff = {
      --   init_options = {
      --     settings = {
      --       organizeImports = true,
      --     },
      --   },
      -- },
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = { command = 'clippy' },
            diagnostics = { experimental = { enable = true } },
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
      'pyright',
    })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
    }

    -- Configure LSP servers
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
