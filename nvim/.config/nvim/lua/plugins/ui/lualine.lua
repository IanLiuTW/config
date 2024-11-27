return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'AndreM222/copilot-lualine', 'meuter/lualine-so-fancy.nvim', 'folke/noice.nvim' },
  config = function()
    local theme = require 'lualine.themes.horizon'
    require('lualine').setup {
      options = {
        theme = theme,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        refresh = {
          statusline = 100,
        },
      },
      sections = {
        lualine_a = {
          { 'fancy_mode', width = 3 },
        },
        lualine_b = {
          { 'fancy_branch' },
          { 'fancy_diff' },
          { 'fancy_diagnostics' },
        },
        lualine_c = {
          { 'fancy_cwd', substitute_home = true },
          { 'filename', file_status = true, path = 1 },
        },
        lualine_x = {
          {
            function()
              local isVisualMode = vim.fn.mode():find '[Vv]'
              if not isVisualMode then
                return ''
              end
              local starts = vim.fn.line 'v'
              local ends = vim.fn.line '.'
              local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
              return '󰒇 ' .. tostring(lines) .. 'L ' .. tostring(vim.fn.wordcount().visual_chars) .. 'C'
            end,
          },
          { 'fancy_macro' },
          { 'fancy_searchcount' },
          { 'fancy_location' },
        },
        lualine_y = {
          { 'encoding' },
          { 'fileformat' },
          { 'fancy_filetype', ts_icon = '' },
          { -- LSP Servers
            function()
              local buf_clients = vim.lsp.get_clients { bufnr = 0 }
              if buf_clients == nil then
                return ''
              end

              local null_ls_installed, null_ls = pcall(require, 'null-ls')
              local buf_client_names = {}
              for _, client in pairs(buf_clients) do
                if client.name == 'null-ls' then
                  if null_ls_installed then
                    for _, source in ipairs(null_ls.get_source { filetype = vim.bo.filetype }) do
                      table.insert(buf_client_names, source.name)
                    end
                  end
                elseif client.name == 'copilot' then
                  -- Skip copilot
                else
                  table.insert(buf_client_names, client.name)
                end
              end
              return '󰌘 ' .. table.concat(buf_client_names, ' ')
            end,
          },
          { -- LSP Formatter
            function()
              -- Check if 'conform' is available
              local status, conform = pcall(require, 'conform')
              if not status then
                return 'Conform not installed'
              end

              local lsp_format = require 'conform.lsp_format'

              -- Get formatters for the current buffer
              local formatters = conform.list_formatters_for_buffer()
              if formatters and #formatters > 0 then
                local formatterNames = {}

                for _, formatter in ipairs(formatters) do
                  if formatter == 'codespell' then
                    -- Skip codespell
                  else
                    table.insert(formatterNames, formatter)
                  end
                end

                return '󰷈 ' .. table.concat(formatterNames, ' ')
              end

              -- Check if there's an LSP formatter
              local bufnr = vim.api.nvim_get_current_buf()
              local lsp_clients = lsp_format.get_format_clients { bufnr = bufnr }

              if not vim.tbl_isempty(lsp_clients) then
                return '󰷈 LSP Formatter'
              end

              return ''
            end,
          },
          {
            'copilot',
            show_colors = true,
            show_loading = true,
            symbols = {
              status = {
                icons = {
                  enabled = ' ',
                  sleep = ' ',
                  disabled = ' ',
                  warning = ' ',
                  unknown = ' ',
                },
              },
            },
          },
          -- {
          --   function()
          --     local status = vim.api.nvim_call_function('codeium#GetStatusString', {})
          --     if not status then
          --       return ''
          --     end
          --     return ' ' .. status
          --   end,
          -- },
        },
        lualine_z = {
          -- { 'datetime', style = ' %H:%M:%S' },
          {
            require('noice').api.status.command.get,
            cond = require('noice').api.status.command.has,
            color = { fg = 'black' },
          },
        },
      },
      extensions = {
        'lazy',
        'mason',
        'fzf',
        'man',
        'neo-tree',
        'oil',
        'overseer',
        'quickfix',
        'symbols-outline',
        'toggleterm',
        'trouble',
      },
    }
  end,
}
