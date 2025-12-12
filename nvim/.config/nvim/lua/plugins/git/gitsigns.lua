return {
  -- See `:help gitsigns` to understand what the configuration keys do
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
      virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
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
      end, { desc = 'GitSigns - Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'GitSigns - Jump to previous git [c]hange' })

      -- visual mode
      map('v', '<leader>cs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'GitSigns - stage git hunk' })
      map('v', '<leader>cr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'GitSigns - reset git hunk' })
      
      -- normal mode
      map('n', '<leader>C', gitsigns.preview_hunk, { desc = 'Gitsigns - Hunk Preview' })
      map('n', '<leader>cc', gitsigns.preview_hunk_inline, { desc = 'GitSigns - Hunk Preview Inline' })

      map('n', '<leader>cs', gitsigns.stage_hunk, { desc = 'Gitsigns - [S]tage hunk' })
      map('n', '<leader>cr', gitsigns.reset_hunk, { desc = 'Gitsigns - [R]eset hunk' })
      map('n', '<leader>cS', gitsigns.stage_buffer, { desc = 'Gitsigns - [S]tage buffer' })
      map('n', '<leader>cR', gitsigns.reset_buffer, { desc = 'Gitsigns - [R]eset buffer' })

      map('n', '<leader>cb', function() gitsigns.blame_line { full = true } end, { desc = 'Gitsigns - [B]lame line' })
      map('n', '<leader>cB', '<cmd>Gitsigns blame<cr>', { desc = 'Gitsigns - [B]lame buffer' })
      
      map('n', '<leader>cd', ':Gitsigns diffthis ', { desc = 'Gitsigns - [D]iff against index' })
      map('n', '<leader>cD', function() gitsigns.diffthis '@' end, { desc = 'Gitsigns - [D]iff against last commit' })
      
      -- Toggles
      map('n', '<leader>cH', gitsigns.toggle_linehl, { desc = 'GitSigns - Toggle show [L]ine highlights' })
      map('n', '<leader>cL', gitsigns.toggle_current_line_blame, { desc = 'GitSigns - Toggle show Blame [L]ine' })
      map('n', '<leader>cW', gitsigns.toggle_word_diff, { desc = 'GitSigns - Toggle show [W]ord diff' })
      
      -- Text objects
      map({ 'o', 'x' }, 'ic', ':<C-U>Gitsigns select_hunk<CR>')
    end,
  },
}
