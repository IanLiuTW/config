return {
  {
    'stevearc/overseer.nvim',
    event = 'BufRead',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },
    keys = {
      { '<leader>R', '<cmd>OverseerRestartLast<cr>', noremap = true, silent = true, desc = 'Overseer - Restart last task' },
      { '<leader>ro', '<cmd>OverseerToggle<cr>', desc = 'Overseer - Task list' },
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Overseer - Run task' },
      { '<leader>rq', '<cmd>OverseerQuickAction<cr>', desc = 'Overseer - Action recent task' },
      { '<leader>ri', '<cmd>OverseerInfo<cr>', desc = 'Overseer - Overseer Info' },
      { '<leader>rb', '<cmd>OverseerBuild<cr>', desc = 'Overseer - Task builder' },
      { '<leader>rt', '<cmd>OverseerTaskAction<cr>', desc = 'Overseer - Task action' },
      { '<leader>rc', '<cmd>OverseerClearCache<cr>', desc = 'Overseer - Clear cache' },
      { '<leader>rs', '<cmd>OverseerSaveBundle<cr>', desc = 'Overseer - Save Bundle' },
      { '<leader>rl', '<cmd>OverseerLoadBundle<cr>', desc = 'Overseer - Load Bundle' },
      { '<leader>rd', '<cmd>OverseerDeleteBundle<cr>', desc = 'Overseer - Delete Bundle' },
      {
        '<leader>rz',
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
        desc = 'Overseer - Add shell scripts in cwd',
      },
    },
    config = function()
      require('overseer').setup {
        strategy = 'toggleterm',
        templates = { 'builtin' },
      }
    end,
    init = function()
      vim.api.nvim_create_user_command('OverseerRestartLast', function()
        local overseer = require 'overseer'
        local tasks = overseer.list_tasks { recent_first = true }
        if vim.tbl_isempty(tasks) then
          vim.notify('No tasks found', vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], 'restart')
        end
      end, {})
    end,
  },
}
