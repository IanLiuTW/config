return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'jvgrootveld/telescope-zoxide' },
      { 'nvim-lua/popup.nvim' },
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-h>'] = 'which_key',
            },
          },
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            theme = 'dropdown',
            previewer = true,
            mappings = {
              i = {
                ['<c-d>'] = require('telescope.actions').delete_buffer,
              },
              n = {
                ['<c-d>'] = require('telescope.actions').delete_buffer,
              },
            },
          },
          grep_string = {
            additional_args = { '--hidden', '--iglob', '!.git' },
          },
          live_grep = {
            additional_args = { '--hidden', '--iglob', '!.git' },
          },
          colorscheme = { enable_preview = true },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          zoxide = {
            prompt_title = '[ Search with Zoxide (Use <C-y> to peek) ]',
            mappings = {
              default = {
                after_action = function(selection)
                  print('Update to (' .. selection.z_score .. ') ' .. selection.path)
                end,
              },
              ['<C-y>'] = {
                before_action = function(selection) end,
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end,
              },
              -- ['<C-q>'] = { action = require('telescope._extensions.zoxide.utils').create_basic_command 'split' },
            },
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'zoxide')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader><leader>F', function()
        builtin.find_files { no_ignore = true, hidden = true }
      end, { desc = 'Search [F]iles' })
      vim.keymap.set('n', '<leader><leader>f', function()
        builtin.git_files()
      end, { desc = 'Search [F]iles in Git' })
      vim.keymap.set('n', '<leader><leader>g', function()
        builtin.live_grep()
      end, { desc = 'Search by [G]rep' })
      vim.keymap.set('n', '<leader><leader>w', function()
        builtin.grep_string()
      end, { desc = 'Search Current [W]ord' })
      vim.keymap.set(
        'x',
        '<leader><leader>w',
        '"zy<Cmd>lua require("telescope.builtin").grep_string({search=vim.fn.getreg("z")})<CR>',
        { desc = 'Search Current [W]ord' }
      )
      vim.keymap.set('n', '<leader><leader>.', builtin.oldfiles, { desc = 'Search [R]ecent Files' })
      vim.keymap.set('n', '<leader><leader>d', builtin.diagnostics, { desc = 'Search [D]iagnostics' })
      vim.keymap.set('n', '<leader><leader>r', builtin.resume, { desc = 'Search [R]esume' })
      vim.keymap.set('n', '<leader><leader>c', builtin.colorscheme, { desc = 'Search [C]olorscheme' })
      vim.keymap.set('n', '<leader><leader>h', builtin.help_tags, { desc = 'Search [H]elp' })
      vim.keymap.set('n', '<leader><leader>k', builtin.keymaps, { desc = 'Search [K]eymaps' })
      vim.keymap.set('n', '<leader><leader>n', '<cmd>Telescope notify<CR>', { desc = 'Search [N]otification' })
      vim.keymap.set('n', '<leader><leader>t', '<cmd>TodoTelescope<CR>', { desc = 'Search [T]odo' })
      vim.keymap.set('n', '<leader><leader>z', '<cmd>Telescope zoxide list<CR>', { desc = 'Search [Z]oxide' })
      vim.keymap.set('n', '<leader><leader><space>', builtin.builtin, { desc = 'Search [B]uiltin of Telescope' })

      vim.keymap.set('n', '<leader><tab>', builtin.buffers, { desc = '[󰌒] Telescope - Find Existing Buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Search in Current Buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader><leader>/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Search [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader><leader>,', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search [,] Neovim Config' })

      -- Git integration
      vim.keymap.set('n', '<leader>g<leader>s', function()
        builtin.git_status()
      end, { desc = 'Telescope - [G]it Status' })
      vim.keymap.set('n', '<leader>g<leader>S', function()
        builtin.git_stash()
      end, { desc = 'Telescope - [G]it Stash' })
      vim.keymap.set('n', '<leader>g<leader>b', function()
        builtin.git_branches()
      end, { desc = 'Telescope - [G]it Search [B]ranches' })
      vim.keymap.set('n', '<leader>g<leader>c', function()
        builtin.git_commits()
      end, { desc = 'Telescope - [G]it Search [C]ommits' })
      vim.keymap.set('n', '<leader>g<leader>C', function()
        builtin.git_bcommits()
      end, { desc = 'Telescope - [G]it Search Buffer [C]ommits' })
    end,
  },
}
