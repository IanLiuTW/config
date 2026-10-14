return {
  {
    'stevearc/overseer.nvim',
    cmd = {
      'OverseerRestartLast',
      'OverseerRun',
      'OverseerShell',
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerTaskAction',
    },
    keys = {
      { '<leader>R', '<cmd>OverseerRestartLast<cr>', noremap = true, silent = true, desc = 'Task - Restart last' },
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Task - Run' },
      { '<leader>rR', '<cmd>OverseerShell<cr>', desc = 'Task - Run shell command' },

      { '<leader>r<space>', '<cmd>OverseerToggle<cr>', desc = 'Task - Toggle list' },
      { '<leader>ra', '<cmd>OverseerTaskAction<cr>', desc = 'Task - Action' },
    },
    config = function()
      require('overseer').setup {
        templates = { 'builtin' },
      }

      vim.api.nvim_create_user_command('OverseerRestartLast', function()
        local overseer = require 'overseer'
        local tasks = overseer.list_tasks { sort = require('overseer.task_list').sort_finished_recently }
        if vim.tbl_isempty(tasks) then
          vim.notify('No tasks found', vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], 'restart')
        end
      end, {})

      vim.api.nvim_create_user_command('Make', function(params)
        local cmd, num_subs = vim.o.makeprg:gsub('%$%*', params.args)
        if num_subs == 0 then
          cmd = cmd .. ' ' .. params.args
        end
        local task = require('overseer').new_task {
          cmd = vim.fn.expandcmd(cmd),
          components = {
            { 'on_output_summarize', max_lines = 10 },
            { 'on_complete_notify' },
            'default',
          },
        }
        task:start()
      end, {
        desc = 'Run your makeprg as an Overseer task',
        nargs = '*',
        bang = true,
      })
    end,
  },
}
