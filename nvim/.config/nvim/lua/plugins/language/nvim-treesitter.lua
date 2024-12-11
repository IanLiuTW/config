return {
  { -- highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      -- [[ configure treesitter ]] see `:help nvim-treesitter`
      require('nvim-treesitter.install').prefer_git = true
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'lua',
          'luadoc',
          'query',
          'regex',
          'vim',
          'vimdoc',
          'diff',
          'git_config',
          'git_rebase',
          'gitcommit',
          'gitignore',
          'markdown',
          'markdown_inline',
          'html',
        },
        -- autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          disable = { 'c', 'rust', 'csv' },
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { 'ruby' },
        },
        incremental_selection = {
          enable = true,
          disable = { 'http', 'markdown' },
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = '<S-CR>',
            node_decremental = '<BS>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['a1'] = { query = '@function.outer', desc = 'Treesitter - Select outer part of a function' },
              ['i1'] = { query = '@function.inner', desc = 'Treesitter - Select inner part of a function' },
              ['a2'] = { query = '@class.outer', desc = 'Treesitter - Select outer part of a class' },
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ['i2'] = { query = '@class.inner', desc = 'Treesitter - Select inner part of a class' },
              -- You can also use captures from other query groups like `locals.scm`
              ['a3'] = { query = '@local.scope', query_group = 'locals', desc = 'Treesitter - Select language scope' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = false,
            swap_next = {
              ['<leader>dl'] = { query = '@parameter.inner', desc = 'Treesitter - Swap parameter with next' },
            },
            swap_previous = {
              ['<leader>dh'] = { query = '@parameter.inner', desc = 'Treesitter - Swap parameter with previous' },
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']1'] = { query = '@function.outer', desc = 'Treesitter - Next function start' },
              [']2'] = { query = '@class.outer', desc = 'Treesitter - Next class start' },
              --
              -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
              [']o'] = { query = '@loop.*', desc = 'Treesitter - ?' },
              -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
              --
              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              [']3'] = { query = '@local.scope', query_group = 'locals', desc = 'Treesitter - Next scope' },
              [']z'] = { query = '@fold', query_group = 'folds', desc = 'Treesitter - Next fold' },
            },
            goto_next_end = {
              [']!'] = { query = '@function.outer', desc = 'Treesitter - Next function end' },
              [']@'] = { query = '@class.outer', desc = 'Treesitter - Next class end' },
            },
            goto_previous_start = {
              ['[1'] = { query = '@function.outer', desc = 'Treesitter - Previous function start' },
              ['[2'] = { query = '@class.outer', desc = 'Treesitter - Previous class start' },
            },
            goto_previous_end = {
              ['[!'] = { query = '@function.outer', desc = 'Treesitter - Previous function end' },
              ['[@'] = { query = '@class.outer', desc = 'Treesitter - Previous class end' },
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
              [']i'] = { query = '@conditional.outer', desc = 'Treesitter - Next conditional' },
            },
            goto_previous = {
              ['[i'] = { query = '@conditional.outer', desc = 'Treesitter - Previous conditional' },
            },
          },
          lsp_interop = {
            enable = true,
            floating_preview_opts = {
              border = 'rounded',
            },
            peek_definition_code = {
              ['<leader>d1'] = { query = '@function.outer', desc = 'Treesitter - Peek outer function' },
              ['<leader>d2'] = { query = '@class.outer', desc = 'Treesitter - Peek outer class' },
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>,t', '<cmd>TSInstallInfo<cr>', { desc = 'Treesitter - Open Install Info' })
      vim.keymap.set('n', '<leader>,i', '<cmd>TSModuleInfo<cr>', { desc = 'Treesitter - Open Module Info' })
      vim.keymap.set('n', '<leader>,H', '<cmd>TSToggle highlight<cr>', { desc = 'Treesitter - Toggle Highlight' })
      vim.keymap.set('n', '<leader>,I', '<cmd>TSToggle indent<cr>', { desc = 'Treesitter - Toggle Indent' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'bufread',
    opts = { multiline_threshold = 1 },
    keys = {
      { '<leader>,X', '<cmd>TSContextToggle<cr>', desc = 'Treesitter - Toggle Context' },
    },
  },
}
