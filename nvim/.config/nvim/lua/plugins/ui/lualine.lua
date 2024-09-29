return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'AndreM222/copilot-lualine', 'meuter/lualine-so-fancy.nvim' },
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
          { 'fancy_mode', width = 8 },
        },
        lualine_b = {
          { 'fancy_branch' },
          { 'fancy_diff' },
        },
        lualine_c = {
          { 'fancy_cwd', substitute_home = true },
          { 'filename', file_status = true, path = 1 },
        },
        lualine_x = {
          { 'fancy_macro' },
          { 'fancy_diagnostics' },
          { 'fancy_searchcount' },
          { 'fancy_location' },
        },
        lualine_y = {
          { 'encoding' },
          { 'fileformat' },
          { 'fancy_filetype', ts_icon = '' },
          { 'fancy_lsp_servers' },
          {
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
                  table.insert(formatterNames, formatter)
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
          -- { 'datetime', style = ' %H:%M:%S' },
        },
        lualine_z = {
          {
            'copilot',
            show_colors = false,
            show_loading = true,
          },
          {
            function()
              local status = vim.api.nvim_call_function('codeium#GetStatusString', {})
              if not status then
                return ''
              end
              return ' ' .. status
            end,
          },
        },
      },
      extensions = { 'oil', 'fugitive', 'fzf', 'lazy', 'man', 'mason', 'neo-tree', 'overseer', 'quickfix', 'symbols-outline', 'toggleterm', 'trouble' },
    }
  end,
}
