return {
  'nvim-lualine/lualine.nvim',
  -- Loads after the first screen is drawn, so Neovim's default statusline shows for one frame
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'meuter/lualine-so-fancy.nvim' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'horizon',
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        refresh = {
          statusline = 500,
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
          {
            'filename',
            file_status = true,
            path = 1,
          },
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
          { 'filetype' },
          { -- LSP servers
            function()
              local buf_client_names = {}
              for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
                if client.name ~= 'copilot' then
                  table.insert(buf_client_names, client.name)
                end
              end
              if #buf_client_names == 0 then
                return ''
              end
              return '󰌘 ' .. table.concat(buf_client_names, ' ')
            end,
          },
          { -- Formatters
            function()
              -- Never empty: conform's `_` entry matches every filetype without its own formatter
              return '󰷈 ' .. table.concat(require('conform').list_formatters_for_buffer(), ' ')
            end,
          },
        },
        lualine_z = {},
      },
      extensions = {
        'lazy',
        'mason',
      },
    }
  end,
}
