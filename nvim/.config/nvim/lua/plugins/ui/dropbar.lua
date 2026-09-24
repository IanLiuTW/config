return {
  'Bekaboo/dropbar.nvim',
  event = 'BufReadPost',
  config = function(_, opts)
    require('dropbar').setup {
      sources = {
        path = {
          max_depth = 1,
        }
      },
      menu = {
        keymaps = {
          ['<C-y>'] = function()
            local menu = require('dropbar.utils.menu').get_current()
            if not menu then
              return
            end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then
              menu:click_on(component, nil, 1, 'l')
            end
          end,
        },
      },
    }

    local dropbar_api = require 'dropbar.api'
    vim.keymap.set('n', "<Leader>'", dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', "['", dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', "]'", dropbar_api.select_next_context, { desc = 'Select next context' })
  end,
}
