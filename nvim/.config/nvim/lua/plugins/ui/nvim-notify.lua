return {
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#000000',
    },
    keys = {
      { '<leader><bs>', ':lua require("notify").dismiss()<CR>', desc = 'Notify - Dismiss Notification' },
    },
  },
}
