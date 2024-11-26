return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-vim-test',
    'rouge8/neotest-rust',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-plenary',
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
        require 'neotest-vim-test' {
          ignore_file_types = { 'python', 'vim', 'lua' },
        },
        require 'neotest-rust',
      },
    }

    vim.keymap.set('n', '<leader>tr', function()
      require('neotest').run.run()
    end, { desc = 'NeoTest: [R]un the nearest test' })
    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = 'NeoTest: Run the current [F]ile' })
    vim.keymap.set('n', '<leader>td', function()
      require('neotest').run.run { strategy = 'dap' }
    end, { desc = 'NeoTest: [D]ebug the nearest test' })
    vim.keymap.set('n', '<leader>tx', function()
      require('neotest').run.stop()
    end, { desc = 'NeoTest: [S]top the test' })
    vim.keymap.set('n', '<leader>ta', function()
      require('neotest').run.attach()
    end, { desc = 'NeoTest: [A]ttach to the test' })
    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').summary.toggle()
    end, { desc = 'NeoTest: Display [S]ummary of tests' })
    vim.keymap.set('n', '<leader>to', function()
      require('neotest').output.open()
    end, { desc = 'NeoTest: Display [O]utput of tests' })
    vim.keymap.set('n', '<leader>tO', function()
      require('neotest').output_panel.toggle()
    end, { desc = 'NeoTest: Open [O]utput Panel of tests' })
    vim.keymap.set('n', '<leader>tw', function()
      require('neotest').watch.toggle()
    end, { desc = 'NeoTest: [W]atch the tests' })
  end,
}
