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
      { 'folke/trouble.nvim' },
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      local actions = require 'telescope.actions'
      local open_with_trouble = require('trouble.sources.telescope').open
      local add_to_trouble = require('trouble.sources.telescope').add
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-/>'] = actions.which_key,
              ['<C-e>'] = open_with_trouble,
              ['<M-q>'] = add_to_trouble,
              ['<C-b>'] = actions.preview_scrolling_up,
              ['<C-f>'] = actions.preview_scrolling_down,
              ['<C-u>'] = actions.results_scrolling_up,
              ['<C-d>'] = actions.results_scrolling_down,
              ['<PageUp>'] = false,
              ['<PageDown>'] = false,
              ['<C-s>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,
              ['<C-t>'] = actions.select_tab,
              ['<C-g>'] = actions.complete_tag,
            },
            n = {
              ['?'] = actions.which_key,
              ['<C-e>'] = open_with_trouble,
              ['<M-q>'] = add_to_trouble,
              ['<C-b>'] = actions.preview_scrolling_up,
              ['<C-f>'] = actions.preview_scrolling_down,
              ['<C-u>'] = actions.results_scrolling_up,
              ['<C-d>'] = actions.results_scrolling_down,
              ['<PageUp>'] = false,
              ['<PageDown>'] = false,
              ['<C-s>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,
              ['<C-t>'] = actions.select_tab,
              ['<C-g>'] = actions.complete_tag,
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
                ['<C-x>'] = require('telescope.actions').delete_buffer,
              },
              n = {
                ['<C-x>'] = require('telescope.actions').delete_buffer,
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
            prompt_title = '[ Search with Zoxide (Use <C-e>/<C-y> to peek) ]',
            mappings = {
              default = {
                after_action = function(selection)
                  print('Update to (' .. selection.z_score .. ') ' .. selection.path)
                end,
              },
              ['<C-e>'] = { action = require('telescope._extensions.zoxide.utils').create_basic_command 'split' },
              ['<C-y>'] = {
                before_action = function(selection) end,
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end,
              },
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
      end, { desc = 'Telescope - Search [F]iles' })
      vim.keymap.set('n', '<leader><leader>f', function()
        builtin.git_files()
      end, { desc = 'Telescope - Search [F]iles in Git' })
      vim.keymap.set('n', '<leader><leader>g', function()
        builtin.live_grep()
      end, { desc = 'Telescope - Search by [G]rep' })
      vim.keymap.set('n', '<leader><leader>w', function()
        builtin.grep_string()
      end, { desc = 'Telescope - Search Current [W]ord' })
      vim.keymap.set(
        'x',
        '<leader><leader>w',
        '"zy<Cmd>lua require("telescope.builtin").grep_string({search=vim.fn.getreg("z")})<CR>',
        { desc = 'Telescope - Search Current [W]ord' }
      )
      vim.keymap.set('n', '<leader><leader>.', builtin.oldfiles, { desc = 'Telescope - Search [R]ecent Files' })
      vim.keymap.set('n', '<leader><leader>d', builtin.diagnostics, { desc = 'Telescope - Search [D]iagnostics' })
      vim.keymap.set('n', '<leader><leader>r', builtin.resume, { desc = 'Telescope - Search [R]esume' })
      vim.keymap.set('n', '<leader><leader>c', builtin.colorscheme, { desc = 'Telescope - Search [C]olorscheme' })
      vim.keymap.set('n', '<leader><leader>?', builtin.help_tags, { desc = 'Telescope - Search [H]elp' })
      vim.keymap.set('n', '<leader><leader>k', builtin.keymaps, { desc = 'Telescope - Search [K]eymaps' })
      -- vim.keymap.set('n', '<leader><leader>n', '<cmd>Telescope notify<CR>', { desc = 'Telescope - Search [N]otification' })
      vim.keymap.set('n', '<leader><leader>;', '<cmd>TodoTelescope<CR>', { desc = 'Telescope - Search [T]odo' })
      vim.keymap.set('n', '<leader><leader>z', '<cmd>Telescope zoxide list<CR>', { desc = 'Telescope - Search [Z]oxide' })
      vim.keymap.set('n', '<leader><leader><space>', builtin.builtin, { desc = 'Telescope - Search Builtin of Telescope' })

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
      end, { desc = 'Telescope - Search [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader><leader>,', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Telescope - Search [,] Neovim Config' })

      -- Git integration
      vim.keymap.set('n', '<leader>gs', function()
        builtin.git_status()
      end, { desc = 'Telescope - Git Status' })
      vim.keymap.set('n', '<leader>gS', function()
        builtin.git_stash()
      end, { desc = 'Telescope - Git Stash' })
      vim.keymap.set('n', '<leader>gb', function()
        builtin.git_branches()
      end, { desc = 'Telescope - Git Search Branches' })
      vim.keymap.set('n', '<leader>gC', function()
        builtin.git_commits()
      end, { desc = 'Telescope - Git Search Commits' })
      vim.keymap.set('n', '<leader>gB', function()
        builtin.git_bcommits()
      end, { desc = 'Telescope - Git Search Buffer Commits' })
    end,
  },
}
