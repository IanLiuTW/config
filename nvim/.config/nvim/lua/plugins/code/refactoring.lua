return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
  },
  lazy = false,
  config = function()
    require('refactoring').setup {
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true,
    }

    vim.keymap.set('x', '<leader>cf', ':Refactor extract ', { desc = 'Refactoring - Extract Function'})
    vim.keymap.set('x', '<leader>cv', ':Refactor extract_var ', { desc = 'Refactoring - Extract Variable'})
    vim.keymap.set('n', '<leader>cF', ':Refactor inline_func', { desc = 'Refactoring - Inline Function'})
    vim.keymap.set({ 'n', 'x' }, '<leader>cV', ':Refactor inline_var', { desc = 'Refactoring - Inline Variable'})
    vim.keymap.set('n', '<leader>cb', ':Refactor extract_block', { desc = 'Refactoring - Extract Block'})
    vim.keymap.set('n', '<leader>cB', ':Refactor extract_block_to_file', { desc = 'Refactoring - Extract Block to File'})
    vim.keymap.set('x', '<leader>cg', ':Refactor extract_to_file ', { desc = 'Refactoring - Extract to File'})

    require('telescope').load_extension 'refactoring'
    vim.keymap.set({ 'n', 'x' }, '<leader>cc', function()
      require('telescope').extensions.refactoring.refactors()
    end, { desc = 'Refactoring - Search Refactors'})

    -- You can also use below = true here to to change the position of the printf
    -- statement (or set two remaps for either one). This remap must be made in normal mode.
    vim.keymap.set('n', '<leader>cp', function()
      require('refactoring').debug.printf { below = false }
    end, { desc = 'Refactoring - Print Function'})
    vim.keymap.set({ 'x', 'n' }, '<leader>cP', function()
      require('refactoring').debug.print_var {}
    end, { desc = 'Refactoring - Print Variable'})
    vim.keymap.set('n', '<leader>cC', function()
      require('refactoring').debug.cleanup {}
    end, { desc = 'Refactoring - Cleanup'})
  end,
}