return {
  'esmuellert/codediff.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cmd = 'CodeDiff',
  keys = {
    {
      '<leader>G',
      '<cmd>CodeDiff<cr>',
      desc = 'Git - CodeDiff',
    },
  },
  config = function()
    require('codediff').setup {
      highlights = {
      },
      keymaps = {
        view = {
          quit = 'q',
          toggle_explorer = '<leader>gt',
          next_hunk = ']c',
          prev_hunk = '[c',
          next_file = ']f',
          prev_file = '[f',
          diff_get = 'do',
          diff_put = 'dp',
        },
        explorer = {
          select = '<CR>',
          hover = 'K',
          refresh = 'R',
          toggle_view_mode = 'i',
        },
        conflict = {
          accept_incoming = '<leader>ht', -- Theirs (left)
          accept_current = '<leader>ho', -- Ours (right)
          accept_both = '<leader>ha', -- Theirs first
          discard = '<leader>hx', -- Keep the base
          next_conflict = ']x',
          prev_conflict = '[x',
          diffget_incoming = '2do', -- Theirs (left)
          diffget_current = '3do', -- Ours (right)
        },
      },
    }
  end,
}
