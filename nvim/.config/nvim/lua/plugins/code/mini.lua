return {
  'nvim-mini/mini.nvim',
  event = 'VeryLazy',
  config = function()
    -- `e` selects the whole buffer
    require('mini.ai').setup {
      n_lines = 80,
      custom_textobjects = {
        e = function()
          local from = { line = 1, col = 1 }
          local last_line = vim.fn.line '$'
          local to = { line = last_line, col = math.max(vim.fn.getline(last_line):len(), 1) }
          return { from = from, to = to }
        end,
      },
    }

    -- Surround keys live under <leader>s because flash owns `s`
    require('mini.surround').setup {
      highlight_duration = 1000,
      mappings = {
        add = '<leader>sa',
        delete = '<leader>sd',
        find = '<leader>sf',
        find_left = '<leader>sF',
        highlight = '<leader>sh',
        replace = '<leader>ss',
        update_n_lines = '<leader>sn',

        suffix_last = 'p',
        suffix_next = 'n',
      },
    }

    -- g= evaluate, gx exchange, gm multiply, gs sort. Replace moves to gp because Neovim's LSP maps use gr
    require('mini.operators').setup {
      replace = {
        prefix = 'gp',
      },
    }

    require('mini.align').setup {
      mappings = {
        start = '<leader>da',
        start_with_preview = '<leader>dA',
      },
    }

    local map = require 'mini.map'
    map.setup {
      integrations = {
        map.gen_integration.gitsigns(),
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic(),
      },
    }
    vim.keymap.set('n', '<leader>um', MiniMap.toggle, { desc = 'Toggle Minimap' })
    vim.keymap.set('n', '<leader>uM', MiniMap.toggle_focus, { desc = 'Toggle Minimap focus' })

    require('mini.bracketed').setup {
      buffer = { suffix = 'b', options = {} },
      comment = { suffix = '/', options = {} },
      conflict = { suffix = 'x', options = {} },
      diagnostic = { suffix = 'd', options = {} },
      file = { suffix = 'f', options = {} },
      indent = { suffix = 'i', options = {} },
      jump = { suffix = 'j', options = {} },
      location = { suffix = 'l', options = {} },
      oldfile = { suffix = 'o', options = {} },
      quickfix = { suffix = 'q', options = {} },
      treesitter = { suffix = 't', options = {} },
      undo = { suffix = 'u', options = {} },
      window = { suffix = '', options = {} }, -- Trouble owns ]w/[w
      yank = { suffix = 'y', options = {} },
    }
  end,
}
