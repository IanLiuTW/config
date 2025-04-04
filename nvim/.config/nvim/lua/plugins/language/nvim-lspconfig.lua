return {
  'neovim/nvim-lspconfig',
  lazy = false,
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
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
    { 'saghen/blink.cmp' },
  },
  opts = {
    servers = {
      -- Disabled: Switching to basedpyright
      --[[ pyright = {
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        },
      }, ]]
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'off',
              autoSearchPaths = true,
            },
          },
        },
      },
      -- Disabled: Using rustaceanvim
      --[[ rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = { command = 'clippy' },
            diagnostics = { experimental = { enable = false } },
            inlayHints = {
              enable = true,
              showParameterNames = true,
              parameterHintsPrefix = '<- ',
              otherHintsPrefix = '=> ',
            },
          },
        },
      }, ]]
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
      marksman = {},
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
    },
  },
  config = function(_, opts)
    -- LSP Attach configuration
    local function setup_lsp(event)
      local map = function(keys, func, desc, mode, mapcheck)
        mode = mode or 'n'

        if not mapcheck or vim.fn.mapcheck(keys, mode) == '' then
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP - ' .. desc })
        end
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- Navigation
      map('<leader>dd', vim.lsp.buf.declaration, 'Goto [D]eclaration')
      -- Search and References
      -- Code Actions and Help
      map('<leader>a', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
      map('S', vim.lsp.buf.signature_help, 'Signature Help')

      -- Information
      map('<Leader>,L', '<cmd>LspInfo<cr>', 'LSP Info')
      -- Inlay hints toggle
      if client and client.supports_method 'textDocument/inlayHint' then
        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        map('<leader>,I', function()
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

      -- Diagnostic navigation because it messes up the highlighting
      if client then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end

    -- Set up LSP attach event
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
      callback = setup_lsp,
    })

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
    local ensure_installed = vim.tbl_keys(opts.servers)
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
    local lspconfig = require 'lspconfig'
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
