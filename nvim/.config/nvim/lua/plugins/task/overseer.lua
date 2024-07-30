return {
  {
    'stevearc/overseer.nvim',
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
      { '<leader>lo', '<cmd>OverseerToggle<cr>', desc = 'Task list' },
      { '<leader>lr', '<cmd>OverseerRun<cr>', desc = 'Run task' },
      { '<leader>lq', '<cmd>OverseerQuickAction<cr>', desc = 'Action recent task' },
      { '<leader>li', '<cmd>OverseerInfo<cr>', desc = 'Overseer Info' },
      { '<leader>lb', '<cmd>OverseerBuild<cr>', desc = 'Task builder' },
      { '<leader>lt', '<cmd>OverseerTaskAction<cr>', desc = 'Task action' },
      { '<leader>lc', '<cmd>OverseerClearCache<cr>', desc = 'Clear cache' },
      { '<leader>ls', '<cmd>OverseerSaveBundle<cr>', desc = 'Save Bundle' },
      { '<leader>ll', '<cmd>OverseerLoadBundle<cr>', desc = 'Load Bundle' },
      { '<leader>ld', '<cmd>OverseerDeleteBundle<cr>', desc = 'Delete Bundle' },
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
      vim.keymap.set('n', '<leader>L', '<cmd>OverseerRestartLast<cr>', { noremap = true, silent = true, desc = 'Restart last task' })
      vim.keymap.set('n', '<leader>lz', function() --Run shell scripts in the current directory
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
      end, { noremap = true, silent = true, desc = 'Add shell scripts in cwd' })
    end,
  },
}
