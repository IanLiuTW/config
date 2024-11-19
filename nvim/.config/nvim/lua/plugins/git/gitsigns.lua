return {
  -- See `:help gitsigns` to understand what the configuration keys do
  'lewis6991/gitsigns.nvim',
  opts = {
    signcolumn = true,
    numhl = true,
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    --   add = { text = '' },
    --   change = { text = '󰜥' },
    --   delete = { text = '▃' },
    --   topdelete = { text = '▔' },
    --   chandelete = { text = '󱣳' },
    },
    signs_staged = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    --   add = { text = '' },
    --   change = { text = '󰜥' },
    --   delete = { text = '▃' },
    --   topdelete = { text = '▔' },
    --   chandelete = { text = '󱣳' },
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
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'GitSigns - stage git hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'GitSigns - reset git hunk' })
      -- normal mode
      map('n', '<leader>H', gitsigns.preview_hunk, { desc = 'Gitsigns - [H]unk Preview' })
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Gitsigns - [s]tage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Gitsigns - [r]eset hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Gitsigns - [S]tage buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Gitsigns - [u]ndo stage hunk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Gitsigns - [R]eset buffer' })
      map('n', '<leader>hb', function()
        gitsigns.blame_line { full = true }
      end, { desc = 'Gitsigns - [b]lame line' })
      map('n', '<leader>hB', '<cmd>Git blame<cr>', { desc = 'Gitsigns - [b]lame buffer' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Gitsigns - [d]iff against index' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis '@'
      end, { desc = 'Gitsigns - [D]iff against last commit' })
      -- Toggles
      map('n', '<leader>hL', gitsigns.toggle_linehl, { desc = 'GitSigns - Toggle show [L]ine highlights' })
      map('n', '<leader>hl', gitsigns.toggle_current_line_blame, { desc = 'GitSigns - Toggle show Blame [L]ine' })
      map('n', '<leader>hx', gitsigns.toggle_deleted, { desc = 'GitSigns - Toggle show deleted' })
      map('n', '<leader>hw', gitsigns.toggle_word_diff, { desc = 'GitSigns - Toggle show [W]ord diff' })
      -- Text objects
      map({ 'o', 'x' }, 'ic', ':<C-U>Gitsigns select_hunk<CR>')
    end,
  },
}
