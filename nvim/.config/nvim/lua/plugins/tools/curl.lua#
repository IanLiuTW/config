return {
  'oysandvik94/curl.nvim',
  cmd = { 'CurlOpen' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = 'BufRead',
  config = function()
    local curl = require 'curl'
    curl.setup {
      default_flags = {},
      mappings = {
        execute_curl = '<CR>',
        close_curl_tab = 'q',
      },
    }

    vim.keymap.set('n', '<leader>vv', function()
      curl.open_curl_tab()
    end, { desc = 'Open a curl tab scoped to the current working directory' })

    vim.keymap.set('n', '<leader>vV', function()
      curl.open_global_tab()
    end, { desc = 'Open a curl tab with global scope' })

    -- These commands will prompt you for a name for your collection
    vim.keymap.set('n', '<leader>vc', function()
      curl.create_scoped_collection()
    end, { desc = 'Create or open a collection with a name from user input' })

    vim.keymap.set('n', '<leader>vC', function()
      curl.create_global_collection()
    end, { desc = 'Create or open a global collection with a name from user input' })

    vim.keymap.set('n', '<leader>vl', function()
      curl.pick_scoped_collection()
    end, { desc = 'Choose a scoped collection and open it' })

    vim.keymap.set('n', '<leader>vL', function()
      curl.pick_global_collection()
    end, { desc = 'Choose a global collection and open it' })
  end,
}
