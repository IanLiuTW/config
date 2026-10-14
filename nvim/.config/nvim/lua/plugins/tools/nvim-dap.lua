return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  -- stylua: ignore
  keys = {
    { '<leader>E',     function() require('dapui').toggle() end,                                                                      desc = 'Debug - Toggle UI' },
    { '<leader>ee',    function() require('dap').toggle_breakpoint() end,                                                             desc = 'Debug - Toggle breakpoint' },
    { '<leader>e<bs>', function() require('dap').clear_breakpoints() end,                                                             desc = 'Debug - Clear breakpoints' },
    { '<leader>ec',    function() require('dap').run_to_cursor() end,                                                                 desc = 'Debug - Run to cursor' },
    { '<leader>eb',    function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,                           desc = 'Debug - Conditional breakpoint' },
    { '<leader>el',    function() require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ') end,                    desc = 'Debug - Log point' },
    { '<leader>eh',    function() require('dap.ui.widgets').hover() end,                                                              desc = 'Debug - Hover' },
    { '<leader>ep',    function() require('dap.ui.widgets').preview() end,                                                            desc = 'Debug - Preview' },
    { '<leader>ef',    function() local widgets = require 'dap.ui.widgets' widgets.centered_float(widgets.frames) end,                desc = 'Debug - Frames' },
    { '<leader>es',    function() local widgets = require 'dap.ui.widgets' widgets.centered_float(widgets.scopes) end,                desc = 'Debug - Scopes' },
    { '<leader>e?',    function() require('dapui').eval(nil, { enter = true }) end,                                                   desc = 'Debug - Eval' },
    { '<F5>',          function() require('dap').continue() end,                                                                      desc = 'Debug - Start / continue' },
    { '<F6>',          function() require('dap').step_into() end,                                                                     desc = 'Debug - Step into' },
    { '<F7>',          function() require('dap').step_over() end,                                                                     desc = 'Debug - Step over' },
    { '<F8>',          function() require('dap').step_out() end,                                                                      desc = 'Debug - Step out' },
    { '<F9>',          function() require('dap').step_back() end,                                                                     desc = 'Debug - Step back' },
    { '<F10>',         function() require('dap').run_last() end,                                                                      desc = 'Debug - Run last' },
    { '<F11>',         function() require('dap').terminate() end,                                                                     desc = 'Debug - Stop' },
    { '<F12>',         function() require('dap').restart() end,                                                                       desc = 'Debug - Restart' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {},
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '',
          play = '',
          step_into = '󰆹',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
          disconnect = '󰩈',
        },
      },
      mappings = {
        edit = 'e',
        expand = { '<2-LeftMouse>', '<CR>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = '<space>',
      },
    }

    require('nvim-dap-virtual-text').setup {}

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
  end,
}
