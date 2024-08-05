return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects - https://github.com/echasnovski/mini.ai
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings - https://github.com/echasnovski/mini.surround
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      highlight_duration = 1000,
      mappings = {
        add = '<leader>ra', -- Add surrounding in Normal and Visual modes
        delete = '<leader>rd', -- Delete surrounding
        find = '<leader>rf', -- Find surrounding (to the right)
        find_left = '<leader>rF', -- Find surrounding (to the left)
        highlight = '<leader>rh', -- Highlight surrounding
        replace = '<leader>rr', -- Replace surrounding
        update_n_lines = '<leader>rn', -- Update `n_lines`

        suffix_last = 'p', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }

    -- Better alignment functionality - https://github.com/echasnovski/mini.align
    require('mini.align').setup {
      mappings = {
        start = '<leader>ca',
        start_with_preview = '<leader>cA',
      },
    }

    -- Show minimap of the current buffer - https://github.com/echasnovski/mini.map
    local map = require 'mini.map'
    map.setup {
      integrations = {
        map.gen_integration.gitsigns(),
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic(),
      },
    }
    vim.keymap.set('n', '<Leader>zm', MiniMap.toggle, { desc = '[M]inimap Toggle' })
    vim.keymap.set('n', '<Leader>zM', MiniMap.toggle_focus, { desc = '[M]inimap Toggle Focus' })

    -- -- Simple and easy statusline.
    -- --  You could remove this setup call if you don't like it,
    -- --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- -- set use_icons to true if you have a Nerd Font
    -- statusline.setup { use_icons = vim.g.have_nerd_font }
    --
    -- -- You can configure sections in the statusline by overriding their
    -- -- default behavior. For example, here we set the section for
    -- -- cursor location to LINE:COLUMN
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    -- require('mini.files').setup {
    --   windows = {
    --     preview = true,
    --     width_preview = 80,
    --   },
    -- }
    -- vim.keymap.set('n', '<leader>.', '<cmd>:lua MiniFiles.open(nil, false)<CR>', { desc = '[.] Open Mini Files' })
    -- -- ... and there is more!
    -- --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
