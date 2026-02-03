return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<C-y>',
          accept_word = '<C-up>',
          accept_line = '<C-down>',
          prev = '<C-left>',
          next = '<C-right>',
          dismiss = '<C-q>',
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          open = '<C-CR>',
          accept = '<CR>',
          jump_prev = '<C-p>',
          jump_next = '<C-n>',
          refresh = 'R',
        },
        layout = {
          position = 'right',
          ratio = 0.4,
        },
      },
      filetypes = {
        python = true,
        yaml = true,
        toml = true,
        json = true,
        jsonc = true,
        javascript = true,
        typescript = true,
        dockerfile = true,
        markdown = true,
        lua = true,
        gitcommit = true,
        gitrebase = true,
        hgcommit = false,
        nix = true,
        svn = false,
        cvs = false,
        help = false,
        ['.'] = false,
      },
      -- Custom should_attach function to enable Copilot in AgenticInput buffers
      should_attach = function(bufnr, bufname)
        local filetype = vim.bo[bufnr].filetype
        if filetype == 'AgenticInput' then
          return true
        end
        local default_should_attach = require('copilot.config.should_attach').default
        return default_should_attach(bufnr, bufname)
      end,
    }
  end,
  vim.keymap.set('n', '<leader>;<Up>', '<Cmd>Copilot enable<CR>'),
  vim.keymap.set('n', '<leader>;<Down>', '<Cmd>Copilot disable<CR>'),
}
