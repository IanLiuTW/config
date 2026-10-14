return {
  'nvim-neotest/neotest',
  lazy = true,
  keys = {
    {
      '<leader>T',
      function()
        require('neotest').run.run()
      end,
      desc = 'Test - Run nearest',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Test - Run file',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = 'Test - Debug nearest',
    },
    {
      '<leader>tx',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Test - Stop',
    },
    {
      '<leader>ta',
      function()
        require('neotest').run.attach()
      end,
      desc = 'Test - Attach',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Test - Summary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open()
      end,
      desc = 'Test - Output',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Test - Output panel',
    },
    {
      '<leader>tw',
      function()
        require('neotest').watch.toggle()
      end,
      desc = 'Test - Watch',
    },
  },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-plenary',
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
      },
    }
  end,
}
