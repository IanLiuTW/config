local hocon_group = vim.api.nvim_create_augroup('treesitter-hocon', { clear = true })
vim.api.nvim_create_autocmd({ 'bufnewfile', 'bufread' }, {
  group = hocon_group,
  pattern = '*.conf',
  command = 'set ft=hocon',
})

return {
  { -- highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':tsupdate',
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
          disable = { 'c', 'rust' },
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { 'ruby' },
        },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<CR>',
              node_incremental = '<CR>',
              scope_incremental = '<S-CR>',
              node_decremental = '<BS>',
            },
          },
      }

      vim.keymap.set('n', '<leader>,t', '<cmd>TSInstallInfo<cr>', { desc = 'Treesitter - Open Install Info' })
      vim.keymap.set('n', '<leader>,T', '<cmd>TSModuleInfo<cr>', { desc = 'Treesitter - Open Module Info' })
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
