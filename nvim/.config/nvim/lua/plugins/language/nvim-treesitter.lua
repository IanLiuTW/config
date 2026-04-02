local highlight_disabled = { c = true, csv = true }
local indent_disabled = { ruby = true }

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {}
      require('nvim-treesitter').install {
        'bash', 'lua', 'luadoc', 'query', 'regex', 'vim', 'vimdoc',
        'diff', 'git_config', 'git_rebase', 'gitcommit', 'gitignore',
        'markdown', 'markdown_inline', 'html', 'yaml',
        'rust', 'python', 'javascript', 'typescript', 'tsx',
        'nix', 'json', 'toml', 'dockerfile', 'go', 'sql', 'css', 'make',
        'just', 'ssh_config', 'ini', 'xml', 'graphql', 'helm',
      }

      local function enable_ts(buf)
        local ft = vim.bo[buf].filetype
        if ft == '' then
          return
        end
        if not highlight_disabled[ft] then
          pcall(vim.treesitter.start, buf)
        end
        if not indent_disabled[ft] then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Enable treesitter highlight and indent',
        callback = function(ev)
          enable_ts(ev.buf)
        end,
      })

      -- Handle buffers restored by auto-session (FileType doesn't re-fire)
      vim.api.nvim_create_autocmd('BufWinEnter', {
        desc = 'Enable treesitter for session-restored buffers',
        callback = function(ev)
          if not vim.b[ev.buf].ts_highlight then
            enable_ts(ev.buf)
          end
        end,
      })

      vim.keymap.set('n', '<leader>,T', '<cmd>TSInstallInfo<cr>', { desc = 'Treesitter - Open Install Info' })
      vim.keymap.set('n', '<leader>,H', function()
        if vim.b.ts_highlight then
          vim.treesitter.stop()
        else
          vim.treesitter.start()
        end
      end, { desc = 'Treesitter - Toggle Highlight' })
      vim.keymap.set('n', '<leader>,I', function()
        if vim.bo.indentexpr ~= '' then
          vim.bo.indentexpr = ''
        else
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end, { desc = 'Treesitter - Toggle Indent' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local ts_select = require 'nvim-treesitter-textobjects.select'
      local ts_swap = require 'nvim-treesitter-textobjects.swap'
      local ts_move = require 'nvim-treesitter-textobjects.move'

      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },
          include_surrounding_whitespace = true,
        },
        move = {
          set_jumps = true,
        },
      }

      -- Select keymaps
      local select_maps = {
        { 'a1', '@function.outer', 'textobjects', 'Treesitter - Select outer part of a function' },
        { 'i1', '@function.inner', 'textobjects', 'Treesitter - Select inner part of a function' },
        { 'a2', '@class.outer', 'textobjects', 'Treesitter - Select outer part of a class' },
        { 'i2', '@class.inner', 'textobjects', 'Treesitter - Select inner part of a class' },
        { 'a3', '@local.scope', 'locals', 'Treesitter - Select language scope' },
      }
      for _, m in ipairs(select_maps) do
        vim.keymap.set({ 'x', 'o' }, m[1], function()
          ts_select.select_textobject(m[2], m[3])
        end, { desc = m[4] })
      end

      -- Swap keymaps
      vim.keymap.set('n', '<leader>dl', function()
        ts_swap.swap_next '@parameter.inner'
      end, { desc = 'Treesitter - Swap parameter with next' })
      vim.keymap.set('n', '<leader>dh', function()
        ts_swap.swap_previous '@parameter.inner'
      end, { desc = 'Treesitter - Swap parameter with previous' })

      -- Move keymaps
      local move_maps = {
        -- goto_next_start
        { ']1', 'goto_next_start', '@function.outer', 'textobjects', 'Treesitter - Next function start' },
        { ']2', 'goto_next_start', '@class.outer', 'textobjects', 'Treesitter - Next class start' },
        { ']o', 'goto_next_start', { '@loop.inner', '@loop.outer' }, 'textobjects', 'Treesitter - Next loop' },
        { ']3', 'goto_next_start', '@local.scope', 'locals', 'Treesitter - Next scope' },
        { ']z', 'goto_next_start', '@fold', 'folds', 'Treesitter - Next fold' },
        -- goto_next_end
        { ']!', 'goto_next_end', '@function.outer', 'textobjects', 'Treesitter - Next function end' },
        { ']@', 'goto_next_end', '@class.outer', 'textobjects', 'Treesitter - Next class end' },
        -- goto_previous_start
        { '[1', 'goto_previous_start', '@function.outer', 'textobjects', 'Treesitter - Previous function start' },
        { '[2', 'goto_previous_start', '@class.outer', 'textobjects', 'Treesitter - Previous class start' },
        -- goto_previous_end
        { '[!', 'goto_previous_end', '@function.outer', 'textobjects', 'Treesitter - Previous function end' },
        { '[@', 'goto_previous_end', '@class.outer', 'textobjects', 'Treesitter - Previous class end' },
        -- goto_next / goto_previous (closest)
        { ']i', 'goto_next', '@conditional.outer', 'textobjects', 'Treesitter - Next conditional' },
        { '[i', 'goto_previous', '@conditional.outer', 'textobjects', 'Treesitter - Previous conditional' },
      }
      for _, m in ipairs(move_maps) do
        vim.keymap.set({ 'n', 'x', 'o' }, m[1], function()
          ts_move[m[2]](m[3], m[4])
        end, { desc = m[5] })
      end
    end,
  },
  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  --   event = 'bufread',
  --   opts = { multiline_threshold = 1 },
  --   keys = {
  --     { '<leader>,X', '<cmd>TSContextToggle<cr>', desc = 'Treesitter - Toggle Context' },
  --   },
  -- },
}
