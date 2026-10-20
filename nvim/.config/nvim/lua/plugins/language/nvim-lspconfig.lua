-- GitHub Copilot through copilot-language-server and Neovim's built-in inline completion
local function setup_copilot()
  local ic = vim.lsp.inline_completion
  local ns = vim.api.nvim_create_namespace 'nvim.lsp.inline_completion'
  local disabled_filetypes = { help = true, hgcommit = true, svn = true, cvs = true }
  local enabled = true

  vim.lsp.config('copilot', {
    root_dir = function(bufnr, on_dir)
      if not disabled_filetypes[vim.bo[bufnr].filetype] then
        on_dir(vim.fs.root(bufnr, '.git') or vim.fn.getcwd())
      end
    end,
  })
  vim.lsp.enable 'copilot'
  ic.enable(true)

  local function visible()
    return #vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { limit = 1 }) > 0
  end

  -- Accept only the leading part of the suggestion that matches one of `patterns`
  local function accept_partial(patterns)
    return ic.get {
      on_accept = function(item)
        local text = item.insert_text
        if type(text) ~= 'string' or not item.range then
          return item
        end
        local cursor = vim.api.nvim_win_get_cursor(0)
        local start_row, start_col = item.range:to_extmark()
        if start_row ~= cursor[1] - 1 then
          return item
        end
        local typed = cursor[2] - start_col
        local rest = text:sub(typed + 1)
        for _, pattern in ipairs(patterns) do
          local piece = rest:match(pattern)
          if piece then
            return vim.tbl_extend('force', item, { insert_text = text:sub(1, typed) .. piece })
          end
        end
        return item
      end,
    }
  end

  local function dismiss()
    ic.enable(false, { bufnr = 0 })
    vim.api.nvim_create_autocmd({ 'TextChangedI', 'InsertLeave' }, {
      buffer = 0,
      once = true,
      callback = function(ev)
        ic.enable(enabled, { bufnr = ev.buf })
      end,
    })
  end

  local function map(lhs, action, fallback, desc)
    vim.keymap.set('i', lhs, function()
      if not visible() then
        return fallback
      end
      vim.schedule(action)
      return ''
    end, { expr = true, desc = 'Copilot - ' .. desc })
  end

  map('<C-y>', ic.get, '<C-y>', 'Accept')
  map('<C-Up>', function()
    accept_partial { '^%s*[%w_]+', '^%s*[^%w_%s]+' }
  end, '<C-Up>', 'Accept Word')
  map('<C-Down>', function()
    accept_partial { '^[^\n]+', '^\n[^\n]*' }
  end, '<C-Down>', 'Accept Line')
  map('<C-Right>', function()
    ic.select { count = 1 }
  end, '<C-Right>', 'Next Suggestion')
  map('<C-Left>', function()
    ic.select { count = -1 }
  end, '<C-Left>', 'Previous Suggestion')
  map('<C-q>', dismiss, '<C-q>', 'Dismiss')

  -- Buffer-level state (set by dismiss and the blink.cmp hooks) overrides the global one, so set both
  local function set_enabled(value)
    enabled = value
    ic.enable(value)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      ic.enable(value, { bufnr = buf })
    end
  end
  Snacks.toggle
    .new({
      id = 'copilot',
      name = 'Copilot',
      get = function()
        return enabled
      end,
      set = set_enabled,
    })
    :map '<leader>ua'

  -- Hide suggestions while the blink.cmp menu is open
  vim.api.nvim_create_autocmd('User', {
    pattern = { 'BlinkCmpMenuOpen', 'BlinkCmpMenuClose' },
    callback = function(ev)
      if enabled then
        ic.enable(ev.match == 'BlinkCmpMenuClose', { bufnr = 0 })
      end
    end,
  })
end

return {
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = {
      PATH = 'skip', -- init.lua puts mason/bin on PATH, so servers start without loading mason
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    cmd = { 'MasonToolsInstall', 'MasonToolsInstallSync', 'MasonToolsUpdate', 'MasonToolsUpdateSync', 'MasonToolsClean' },
    opts = {
      ensure_installed = {
        'stylua',
        'prettier',
        'prettierd',
        'ruff',
        'codespell',
        'marksman',
        'lua-language-server',
        'ty',
        'nil',
        'rust-analyzer',
        'copilot-language-server',
        'debugpy',
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 24,
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Semantic tokens are turned off: they override treesitter highlighting
      vim.lsp.semantic_tokens.enable(false)

      -- What blink.cmp's get_lsp_capabilities() adds to the defaults. Set here so servers
      -- get it without loading blink (InsertEnter) at file open. Recheck after blink updates:
      -- :lua =require('blink.cmp').get_lsp_capabilities().textDocument.completion
      vim.lsp.config('*', {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                insertTextModeSupport = { valueSet = { 1 } },
                resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits', 'command', 'data' } },
              },
              completionList = { itemDefaults = { 'commitCharacters', 'editRange', 'insertTextFormat', 'insertTextMode', 'data' } },
              insertTextMode = 1,
            },
          },
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'Code - ' .. desc })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          map('<leader>cD', vim.lsp.buf.declaration, 'Declaration')
          map('<c-s-k>', vim.lsp.buf.signature_help, 'Signature help', { 'i', 'n', 'x', 's' })

          -- Inlay hints start on; <leader>ui toggles them per buffer
          if client and client:supports_method 'textDocument/inlayHint' then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end
        end,
      })

      -- Language servers
      vim.lsp.config('lua_ls', {
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
      })
      vim.lsp.enable 'lua_ls'

      vim.lsp.enable 'marksman'

      vim.lsp.config('ty', {
        settings = {
          ty = {},
        },
      })
      vim.lsp.enable 'ty'

      vim.lsp.config('nil_ls', {
        settings = {
          ['nil'] = {
            formatting = {
              command = { 'nixfmt' },
            },
            nix = {
              maxMemoryMB = 2048,
              flake = {
                autoEvalInputs = false, -- Evaluating every flake input costs too much memory
              },
            },
          },
        },
      })
      vim.lsp.enable 'nil_ls'

      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            check = { command = 'clippy' },
            diagnostics = { experimental = { enable = true } },
          },
        },
      })
      vim.lsp.enable 'rust_analyzer'

      setup_copilot()
    end,
  },
}
