return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      preset = {
        keys = {
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = '\\', desc = 'File Browser (Neo-Tree)', action = ':Neotree reveal' },
          { icon = ' ', key = '-', desc = 'File Browser (Oil)', action = ':Oil --float' },
          { icon = ' ', key = 'r', desc = 'Restore CWD Session', action = ':SessionLoad' },
          { icon = ' ', key = '.', desc = 'Restore Last Session', action = ':SessionLoadLast' },
          { icon = '󱦞 ', key = '/', desc = 'Select Session', action = ':Telescope persisted' },
          {
            text = {
              { '  ', hl = 'SnacksDashboardIcon' },
              { 'Search File', hl = 'SnacksDashboardDesc', width = 50 },
              { '󱁐  󱁐  f', hl = 'SnacksDashboardKey' },
            },
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            text = {
              { '  ', hl = 'SnacksDashboardIcon' },
              { 'Search Recent Files', hl = 'SnacksDashboardDesc', width = 50 },
              { '󱁐  󱁐  .', hl = 'SnacksDashboardKey' },
            },
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            text = {
              { '  ', hl = 'SnacksDashboardIcon' },
              { 'Search with Live Grep', hl = 'SnacksDashboardDesc', width = 50 },
              { '󱁐  󱁐  g', hl = 'SnacksDashboardKey' },
            },
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          { icon = ' ', key = 'g', desc = 'Open Neogit', action = ':Neogit' },
          { icon = '󰀬 ', key = 'm', desc = 'Open Mason', action = ':Mason' },
          { icon = '󰒲 ', key = ',', desc = 'Open Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'u', desc = 'Update Plugins', action = ':Lazy update' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        header = {
          { '████████╗██╗  ██╗██╗███████╗    ██╗███████╗    ██╗ █████╗ ███╗   ██╗\n', hl = 'NeovimDashboardLogo1' },
          { '╚══██╔══╝██║  ██║██║██╔════╝    ██║██╔════╝    ██║██╔══██╗████╗  ██║\n', hl = 'NeovimDashboardLogo2' },
          { '   ██║   ███████║██║███████╗    ██║███████╗    ██║███████║██╔██╗ ██║\n', hl = 'NeovimDashboardLogo3' },
          { '   ██║   ██╔══██║██║╚════██║    ██║╚════██║    ██║██╔══██║██║╚██╗██║\n', hl = 'NeovimDashboardLogo4' },
          { '   ██║   ██║  ██║██║███████║    ██║███████║    ██║██║  ██║██║ ╚████║\n', hl = 'NeovimDashboardLogo5' },
          { '   ╚═╝   ╚═╝  ╚═╝╚═╝╚══════╝    ╚═╝╚══════╝    ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝', hl = 'NeovimDashboardLogo6' },
        },
      },
      sections = {
        { section = 'header' },
        {
          pane = 2,
          section = 'terminal',
          cmd = 'colorscript -e spectrum',
          height = 7,
          padding = 1,
          indent = 8,
        },
        { section = 'keys', gap = 1, padding = 1 },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = 'git status --short --branch --renames',
          height = 14,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = {
      left = { 'mark', 'fold' }, -- priority of signs on the left (high to low)
      right = { 'sign', 'git' }, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
      refresh = 50, -- refresh at most every 50ms },
    },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    {
      '<leader>bb',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>b<leader>',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader><BS>',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Snacks Buffer - Buffer',
    },
    {
      '<leader>df',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'LSP - Rename File',
    },
    {
      '<leader>g<CR>',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Snacks Git - Browse',
    },
    -- { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    -- { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    -- { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    -- { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    -- { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    {
      '<BS>',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Snacks Notifier - Dismiss All',
    },
    {
      '<leader>,n',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Snacks Notifier - Show History',
    },
    {
      '<leader>ps',
      function()
        Snacks.profiler.scratch()
      end,
      desc = 'Snacks Profiler - Scratch Buffer',
    },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>,<leader>',
      desc = 'Neovim News',
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end,
    },
  },
  init = function()
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo1', { fg = '#c5b102' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo2', { fg = '#cec139' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo3', { fg = '#d7d15a' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo4', { fg = '#e1e078' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo5', { fg = '#ebf096' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo6', { fg = '#f7ffb3' })

    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd('LspProgress', {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= 'table' then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ('[%3d%%] %s%s'):format(
                value.kind == 'end' and 100 or value.percentage or 100,
                value.title or '',
                value.message and (' **%s**'):format(value.message) or ''
              ),
              done = value.kind == 'end',
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
          id = 'lsp_progress',
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>,S'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>z'
        Snacks.toggle.diagnostics():map '<leader>,D'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>,C'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>,B'
        Snacks.toggle.treesitter():map '<leader>,T'

        -- Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>,R'
        -- Snacks.toggle.line_number():map '<leader>,N'
        -- Snacks.toggle.inlay_hints():map '<leader>uh'
      end,
    })
  end,
}