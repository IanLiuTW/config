return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  event = 'BufEnter',
  config = function()
    -- Better Around/Inside textobjects - https://github.com/echasnovski/mini.ai
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 80 }

    -- Add/delete/replace surroundings - https://github.com/echasnovski/mini.surround
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      highlight_duration = 1000,
      mappings = {
        add = '<leader>sa', -- Add surrounding in Normal and Visual modes
        delete = '<leader>sd', -- Delete surrounding
        find = '<leader>sf', -- Find surrounding (to the right)
        find_left = '<leader>sF', -- Find surrounding (to the left)
        highlight = '<leader>sh', -- Highlight surrounding
        replace = '<leader>ss', -- Replace surrounding
        update_n_lines = '<leader>sn', -- Update `n_lines`

        suffix_last = 'p', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }

    -- Introduce new operators - https://github.com/echasnovski/mini.operators
    -- - g= - evaluate
    -- - gx - exchange
    -- - gm - multiply
    -- - gr - replace
    -- - gs - sort
    require('mini.operators').setup {}

    -- Better alignment functionality - https://github.com/echasnovski/mini.align
    require('mini.align').setup {
      mappings = {
        start = '<leader>da',
        start_with_preview = '<leader>dA',
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
    vim.keymap.set('n', '<leader>m', MiniMap.toggle, { desc = 'Minimap - Toggle' })
    vim.keymap.set('n', '<leader>M', MiniMap.toggle_focus, { desc = 'Minimap - Toggle Focus' })

    -- require('mini.pairs').setup {}

    -- require('mini.indentscope').setup {}

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
