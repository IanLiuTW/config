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
      { '<leader>Y', '<cmd>OverseerRestartLast<cr>', noremap = true, silent = true, desc = 'Overseer - Restart Last Task' },
      { '<leader>yr', '<cmd>OverseerRun<cr>', desc = 'Overseer - Run Task' },
      { '<leader>yR', '<cmd>OverseerShell<cr>', desc = 'Overseer - Run Shell Command' },

      { '<leader>y<space>', '<cmd>OverseerToggle<cr>', desc = 'Overseer - Toggle Task List' },
      { '<leader>ya', '<cmd>OverseerTaskAction<cr>', desc = 'Overseer - Task Action' },
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
