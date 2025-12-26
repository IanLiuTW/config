return {
  'folke/sidekick.nvim',
  opts = {},
  keys = {
    {
      '<S-CR>',
      function()
        if not require('sidekick').nes_jump_or_apply() then
          return '<S-CR>'
        end
      end,
      expr = true,
      desc = 'Sidekick - Goto/Apply Next Edit Suggestion',
    },
    {
      '<leader>:',
      function()
        require('sidekick.cli').toggle()
      end,
      desc = 'Sidekick - Toggle CLI',
      mode = { 'n', 't',  'x' },
    },
    {
      '<leader>;;',
      function()
        require('sidekick.cli').select()
      end,
      desc = 'Sidekick - Select CLI',
    },
    {
      '<leader>;d',
      function()
        require('sidekick.cli').close()
      end,
      desc = 'Sidekick - Detach a CLI Session',
    },
    {
      '<leader>;t',
      function()
        require('sidekick.cli').send { msg = '{this}' }
      end,
      mode = { 'x', 'n' },
      desc = 'Sidekick - Send This',
    },
    {
      '<leader>;f',
      function()
        require('sidekick.cli').send { msg = '{file}' }
      end,
      desc = 'Sidekick - Send File',
    },
    {
      '<leader>;v',
      function()
        require('sidekick.cli').send { msg = '{selection}' }
      end,
      mode = { 'x' },
      desc = 'Sidekick - Send Visual Selection',
    },
    {
      '<leader>;<leader>',
      function()
        require('sidekick.cli').prompt()
      end,
      mode = { 'n', 'x' },
      desc = 'Sidekick - Sidekick Select Prompt',
    },
    {
      '<leader>;g',
      function()
        require('sidekick.cli').toggle { name = 'gemini', focus = true }
      end,
      desc = 'Sidekick - Sidekick Toggle Gemini',
    },
  },
}
