return {
  {
    'stevearc/overseer.nvim',
    event = 'BufRead',
    cmd = {
      'OverseerRestartLast',
      'OverseerRun',
      'OverseerRunCmd',
      'OverseerBuild',
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerTaskAction',
      'OverseerQuickAction',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerInfo',
      'OverseerClearCache',
    },
    keys = {
      { '<leader>R', '<cmd>OverseerRestartLast<cr>', noremap = true, silent = true, desc = 'Overseer - Restart Last Task' },
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Overseer - Run Task' },
      { '<leader>rR', '<cmd>OverseerRunCmd<cr>', desc = 'Overseer - Run Cmd' },
      { '<leader>rb', '<cmd>OverseerBuild<cr>', desc = 'Overseer - Build Task' },

      { '<leader>r<space>', '<cmd>OverseerToggle<cr>', desc = 'Overseer - Toggle Task List' },
      { '<leader>ra', '<cmd>OverseerTaskAction<cr>', desc = 'Overseer - Task Action' },
      { '<leader>rq', '<cmd>OverseerQuickAction<cr>', desc = 'Overseer - Quick Action (Recent Task)' },

      { '<leader>rs', '<cmd>OverseerSaveBundle<cr>', desc = 'Overseer - Bundle Save' },
      { '<leader>rl', '<cmd>OverseerLoadBundle<cr>', desc = 'Overseer - Bundle Load' },
      { '<leader>rx', '<cmd>OverseerDeleteBundle<cr>', desc = 'Overseer - Bundle Delete' },

      { '<leader>r?', '<cmd>OverseerInfo<cr>', desc = 'Overseer - Overseer Info' },
      { '<leader>r<BS>', '<cmd>OverseerClearCache<cr>', desc = 'Overseer - Clear Cache' },
      {
        '<leader>r.',
        function() --Run shell scripts in the current directory
          local files = require 'overseer.files'
          return {
            generator = function(opts, cb)
              local scripts = vim.tbl_filter(function(filename)
                return filename:match '%.sh$'
              end, files.list_files(opts.dir))
              local ret = {}
              for _, filename in ipairs(scripts) do
                table.insert(ret, {
                  name = filename,
                  params = {
                    args = { optional = true, type = 'list', delimiter = ' ' },
                  },
                  builder = function(params)
                    return {
                      cmd = { files.join(opts.dir, filename) },
                      args = params.args,
                    }
                  end,
                })
              end

              cb(ret)
            end,
          }
        end,
        noremap = true,
        silent = true,
        desc = 'Overseer - Add Shell Scripts in CWD',
      },
    },
    config = function()
      require('overseer').setup {
        strategy = 'toggleterm',
        templates = { 'builtin' },
      }

      vim.api.nvim_create_user_command('OverseerRestartLast', function()
        local overseer = require 'overseer'
        local tasks = overseer.list_tasks { recent_first = true }
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
