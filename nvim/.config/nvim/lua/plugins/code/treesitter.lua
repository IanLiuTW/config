local hocon_group = vim.api.nvim_create_augroup('treesitter-hocon', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, { group = hocon_group, pattern = '*.conf', command = 'set ft=hocon' })

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
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
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'c', 'rust' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      additional_vim_regex_highlighting = false,
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

      vim.keymap.set('n', '<leader>zt', '<Cmd>TSInstallInfo<CR>', { desc = '[T]reesitter - Open Install Info' })
      vim.keymap.set('n', '<leader>zT', '<Cmd>TSModuleInfo<CR>', { desc = '[T]reesitter - Open Module Info' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufRead',
    opts = { multiline_threshold = 1 },
    keys = {
      { '<leader>zx', '<Cmd>TSContextToggle<CR>', desc = 'Toggle Treesitter Conte[X]t' },
    },
  },
}
