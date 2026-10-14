return {
  'cameron-wags/rainbow_csv.nvim',
  lazy = true,
  ft = {
    'csv',
    'tsv',
    'csv_semicolon',
    'csv_whitespace',
    'csv_pipe',
    'rfc_csv',
    'rfc_semicolon',
  },
  cmd = {
    'RainbowDelim',
    'RainbowDelimSimple',
    'RainbowDelimQuoted',
    'RainbowMultiDelim',
  },
  keys = {
    { '<leader>dc', '<cmd>RainbowAlign<CR>', desc = 'Edit - Align CSV' },
    { '<leader>dC', '<cmd>RainbowDelim<CR>', desc = 'Edit - Set CSV delimiter' },
  },
  config = function()
    vim.g.disable_rainbow_statusline = 1
    require('rainbow_csv').setup()
  end,
}
