return {
  'lewis6991/gitsigns.nvim',
  event = 'BufRead',
  opts = {
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '▃' },
      topdelete = { text = '▔' },
      changedelete = { text = '󰇙' },
      untracked = { text = '┆' },
    },
    signs_staged = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '▃' },
      topdelete = { text = '▔' },
      changedelete = { text = '󰇙' },
      untracked = { text = '┆' },
    },
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'right_align',
      delay = 100,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = '   <author> (<author_time:%R>) - <summary> ',
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Hunk - Next' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Hunk - Previous' })

      -- Visual mode
      map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Hunk - Stage selection' })
      map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Hunk - Reset selection' })
      
      -- Normal mode
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Hunk - Preview' })
      map('n', '<leader>hP', gitsigns.preview_hunk_inline, { desc = 'Hunk - Preview inline' })

      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Hunk - Stage' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Hunk - Reset' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Hunk - Stage buffer' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Hunk - Reset buffer' })

      -- <leader>hb (blame line) is mapped by Snacks
      map('n', '<leader>hB', '<cmd>Gitsigns blame<cr>', { desc = 'Hunk - Blame buffer' })
      
      map('n', '<leader>hd', ':Gitsigns diffthis ', { desc = 'Hunk - Diff against index' })
      map('n', '<leader>hD', function() gitsigns.diffthis '@' end, { desc = 'Hunk - Diff against last commit' })
      
      -- Toggles live under <leader>ug (snacks.lua)

      -- Text objects
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Hunk - Select' })
    end,
  },
}
