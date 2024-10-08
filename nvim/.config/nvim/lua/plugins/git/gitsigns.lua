return {
  -- See `:help gitsigns` to understand what the configuration keys do
  'lewis6991/gitsigns.nvim',
  opts = {
    signcolumn = true,
    numhl = true,
    signs = {
      add = { text = '' },
      change = { text = '󰜥' },
      delete = { text = '▃' },
      topdelete = { text = '▔' },
      chandelete = { text = '󱣳' },
    },
    signs_staged = {
      add = { text = '' },
      change = { text = '󰜥' },
      delete = { text = '▃' },
      topdelete = { text = '▔' },
      chandelete = { text = '󱣳' },
    },
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
      end, { desc = 'GitSigns - Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'GitSigns - Jump to previous git [c]hange' })

      -- Actions
      -- visual mode
      map('v', '<leader>gs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'GitSigns - stage git hunk' })
      map('v', '<leader>gr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'GitSigns - reset git hunk' })
      -- normal mode
      map('n', '<leader>G', gitsigns.preview_hunk, { desc = 'Gitsigns - Preview hunk' })
      map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Gitsigns - [s]tage hunk' })
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Gitsigns - [r]eset hunk' })
      map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Gitsigns - [S]tage buffer' })
      map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Gitsigns - [u]ndo stage hunk' })
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Gitsigns - [R]eset buffer' })
      map('n', '<leader>gb', gitsigns.blame_line, { desc = 'Gitsigns - [b]lame line' })
      map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Gitsigns - [d]iff against index' })
      map('n', '<leader>gD', function()
        gitsigns.diffthis '@'
      end, { desc = 'Gitsigns - [D]iff against last commit' })
      -- Toggles
      map('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = 'GitSigns - Toggle show [B]lame line' })
      map('n', '<leader>gq', gitsigns.toggle_deleted, { desc = 'GitSigns - Toggle show deleted' })
      map('n', '<leader>gl', gitsigns.toggle_linehl, { desc = 'GitSigns - Toggle show [L]ine highlights' })
      map('n', '<leader>gw', gitsigns.toggle_word_diff, { desc = 'GitSigns - Toggle show [W]ord diff' })
    end,
  },
}
