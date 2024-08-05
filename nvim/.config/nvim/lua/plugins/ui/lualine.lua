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
          {
            'copilot',
            symbols = {
              status = {
                icons = {
                  enabled = ' ',
                  sleep = ' ', -- auto-trigger disabled
                  disabled = ' ',
                  warning = ' ',
                  unknown = ' ',
                },
                hl = {
                  enabled = '#50FA7B',
                  sleep = '#AEB7D0',
                  disabled = '#6272A4',
                  warning = '#FFB86C',
                  unknown = '#FF5555',
                },
              },
              spinners = require('copilot-lualine.spinners').dots,
              spinner_color = '#6272A4',
            },
            show_colors = true,
            show_loading = true,
          },
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
        },
        lualine_z = {
          { 'datetime', style = ' %H:%M:%S' },
        },
      },
      extensions = { 'oil', 'fugitive', 'fzf', 'lazy', 'man', 'mason', 'neo-tree', 'overseer', 'quickfix', 'symbols-outline', 'toggleterm', 'trouble' },
    }
  end,
}
