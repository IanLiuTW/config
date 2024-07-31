return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--hidden',
        },
      },
    },
    init = function()
      vim.keymap.set('n', '].', function()
        require('todo-comments').jump_next()
      end, { desc = 'Jump to next todo' })

      vim.keymap.set('n', '[.', function()
        require('todo-comments').jump_prev()
      end, { desc = 'Jump to previous todo' })
    end,
  },
  {
    'ziontee113/icon-picker.nvim',
    config = function()
      require('icon-picker').setup { disable_legacy_commands = true }

      vim.keymap.set('n', '<Leader>zi', '<cmd>IconPickerNormal<cr>', { desc = '[I]con insert', noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>zI', '<cmd>IconPickerYank<cr>', { desc = '[I]con yank', noremap = true, silent = true })
      vim.keymap.set('i', '<A-i>', '<cmd>IconPickerInsert<cr>', { desc = '[I]con insert', noremap = true, silent = true })
    end,
  },
}
