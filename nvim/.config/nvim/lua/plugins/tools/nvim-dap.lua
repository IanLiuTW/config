return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- Creates a beautiful debugger UI
    'nvim-neotest/nvim-nio', -- Required dependency for nvim-dap-ui
    'theHamsta/nvim-dap-virtual-text',
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  event = 'BufReadPre',
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      { '<leader>E',     dapui.toggle,                                                                                   desc = 'Debug: Toggle [D]AP UI' },
      { '<leader>ee',    dap.toggle_breakpoint,                                                                          desc = 'Debug: Toggle [B]reakpoint' },
      { '<leader>e<bs>', dap.clear_breakpoints,                                                                          desc = 'Debug: Clear Breakpoint' },
      { '<leader>ec',    dap.run_to_cursor,                                                                              desc = 'Debug: Run to [C]ursor' },
      { '<leader>eb',    function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,                       desc = 'Debug: Set [B]reakpoint' },
      { '<leader>el',    function() dap.set_breakpoint(nil,nil,vim.fn.input 'Log point message: ') end,                  desc = 'Debug: [L]og Point' },
      { '<leader>eh',    function() require('dap.ui.widgets').hover() end,                                               desc = 'Debug: Hover' },
      { '<leader>ep',    function() require('dap.ui.widgets').preview() end,                                             desc = 'Debug: Preview' },
      { '<leader>ef',    function() local widgets = require 'dap.ui.widgets' widgets.centered_float(widgets.frames) end, desc = 'Debug: Frames' },
      { '<leader>es',    function() local widgets = require 'dap.ui.widgets' widgets.centered_float(widgets.scopes) end, desc = 'Debug: Scopes' },
      { '<leader>e?',    function() dapui.eval(nil,{ enter = true }) end,                                                desc = 'Debug: Eval' },
      { '<F5>',          dap.continue,                                                                                   desc = 'Debug: Start/Continue' },
      { '<F6>',          dap.step_into,                                                                                  desc = 'Debug: Step Into' },
      { '<F7>',          dap.step_over,                                                                                  desc = 'Debug: Step Over' },
      { '<F8>',          dap.step_out,                                                                                   desc = 'Debug: Step Out' },
      { '<F9>',          dap.step_back,                                                                                  desc = 'Debug: Step Back' },
      { '<F10>',         dap.run_last,                                                                                   desc = 'Debug: Run Last' },
      { '<F11>',         dap.terminate,                                                                                  desc = 'Debug: Terminate' },
      { '<F12>',         dap.restart,                                                                                    desc = 'Debug: Restart' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
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
