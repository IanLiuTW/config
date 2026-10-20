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
        'nix', 'json', 'json5', 'toml', 'dockerfile', 'go', 'sql', 'css', 'make',
        'just', 'ssh_config', 'ini', 'xml', 'hocon', 'graphql', 'helm',
      }

      local function enable_ts(buf)
        local ft = vim.bo[buf].filetype
        if ft == '' then
          return
        end
        vim.b[buf].ts_setup_done = true
        if not highlight_disabled[ft] then
          pcall(vim.treesitter.start, buf)
        end
        -- Without an indents query the treesitter indentexpr returns 0/-1; keep the ftplugin's indent instead
        local lang = vim.treesitter.language.get_lang(ft)
        if not indent_disabled[ft] and lang and vim.treesitter.query.get(lang, 'indents') then
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
          if not vim.b[ev.buf].ts_setup_done then
            enable_ts(ev.buf)
          end
        end,
      })

      -- Highlight and indent toggles live under <leader>u (snacks.lua)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
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
        { 'a1', '@function.outer', 'textobjects', 'Select - Around function' },
        { 'i1', '@function.inner', 'textobjects', 'Select - Inside function' },
        { 'a2', '@class.outer', 'textobjects', 'Select - Around class' },
        { 'i2', '@class.inner', 'textobjects', 'Select - Inside class' },
        { 'a3', '@local.scope', 'locals', 'Select - Around scope' },
      }
      for _, m in ipairs(select_maps) do
        vim.keymap.set({ 'x', 'o' }, m[1], function()
          ts_select.select_textobject(m[2], m[3])
        end, { desc = m[4] })
      end

      -- Swap keymaps
      vim.keymap.set('n', '<leader>dl', function()
        ts_swap.swap_next '@parameter.inner'
      end, { desc = 'Edit - Swap parameter right' })
      vim.keymap.set('n', '<leader>dh', function()
        ts_swap.swap_previous '@parameter.inner'
      end, { desc = 'Edit - Swap parameter left' })

      -- Move keymaps
      local move_maps = {
        { ']1', 'goto_next_start', '@function.outer', 'textobjects', 'Jump - Next function start' },
        { ']2', 'goto_next_start', '@class.outer', 'textobjects', 'Jump - Next class start' },
        { ']3', 'goto_next_start', '@local.scope', 'locals', 'Jump - Next scope' },
        { ']z', 'goto_next_start', '@fold', 'folds', 'Jump - Next fold' },
        { ']!', 'goto_next_end', '@function.outer', 'textobjects', 'Jump - Next function end' },
        { ']@', 'goto_next_end', '@class.outer', 'textobjects', 'Jump - Next class end' },
        { '[1', 'goto_previous_start', '@function.outer', 'textobjects', 'Jump - Previous function start' },
        { '[2', 'goto_previous_start', '@class.outer', 'textobjects', 'Jump - Previous class start' },
        { '[!', 'goto_previous_end', '@function.outer', 'textobjects', 'Jump - Previous function end' },
        { '[@', 'goto_previous_end', '@class.outer', 'textobjects', 'Jump - Previous class end' },
      }
      for _, m in ipairs(move_maps) do
        vim.keymap.set({ 'n', 'x', 'o' }, m[1], function()
          ts_move[m[2]](m[3], m[4])
        end, { desc = m[5] })
      end
    end,
  },
}
