local hocon_group = vim.api.nvim_create_augroup('treesitter-hocon', { clear = true })
vim.api.nvim_create_autocmd({ 'bufnewfile', 'bufread' }, { group = hocon_group, pattern = '*.conf', command = 'set ft=hocon' })

return {
  { -- highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':tsupdate',
    opts = {
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
        disable = { 'c', 'rust' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      additional_vim_regex_highlighting = false,
    },
    config = function(_, opts)
      -- [[ configure treesitter ]] see `:help nvim-treesitter`

      -- prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        highlight = {
          encble = false,
          -- setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- using this option may slow down your editor, and you may see some duplicate highlights.
          -- instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        require('nvim-treesitter.configs').setup {
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<CR>',
              node_incremental = '<CR>',
              scope_incremental = '<S-CR>',
              node_decremental = '<BS>',
            },
          },
        },
        indent = {
          enable = false,
        },
      }

      -- there are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. you should go explore a few and see what interests you:
      --
      --    - incremental selection: included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

      vim.keymap.set('n', '<leader>,t', '<cmd>tsinstallinfo<cr>', { desc = '[t]reesitter - open install info' })
      vim.keymap.set('n', '<leader>,t', '<cmd>tsmoduleinfo<cr>', { desc = '[t]reesitter - open module info' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'bufread',
    opts = { multiline_threshold = 1 },
    keys = {
      { '<leader>,x', '<cmd>tscontexttoggle<cr>', desc = 'toggle treesitter conte[x]t' },
    },
  },
}
