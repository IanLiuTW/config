---@diagnostic disable: undefined-global
-- stylua: ignore
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animation = {
      fps = 100, -- frames per second. Global setting for all animations
    },
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
            text = { { '  ', hl = 'SnacksDashboardIcon' }, { 'Search File', hl = 'SnacksDashboardDesc', width = 50 }, { '󱁐  󱁐  f', hl = 'SnacksDashboardKey' }, },
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            text = { { '  ', hl = 'SnacksDashboardIcon' }, { 'Search Recent Files', hl = 'SnacksDashboardDesc', width = 50 }, { '󱁐  󱁐  .', hl = 'SnacksDashboardKey' }, },
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            text = { { '  ', hl = 'SnacksDashboardIcon' }, { 'Search with Live Grep', hl = 'SnacksDashboardDesc', width = 50 }, { '󱁐  󱁐  g', hl = 'SnacksDashboardKey' }, },
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
        function()
          vim.api.nvim_set_hl(0, 'NeovimDashboardLogo1', { fg = '#c5b102' })
          vim.api.nvim_set_hl(0, 'NeovimDashboardLogo2', { fg = '#cec139' })
          vim.api.nvim_set_hl(0, 'NeovimDashboardLogo3', { fg = '#d7d15a' })
          vim.api.nvim_set_hl(0, 'NeovimDashboardLogo4', { fg = '#e1e078' })
          vim.api.nvim_set_hl(0, 'NeovimDashboardLogo5', { fg = '#ebf096' })
          vim.api.nvim_set_hl(0, 'NeovimDashboardLogo6', { fg = '#f7ffb3' })
        end,
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
          ttl = 15,
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
    -- input = { enabled = true },
    indent = {
      indent = {
        char = '│',
        blank = ' ',
        -- blank = "∙",
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = 'SnacksIndent', ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        -- hl = {
        --     "SnacksIndent1",
        --     "SnacksIndent2",
        --     "SnacksIndent3",
        --     "SnacksIndent4",
        --     "SnacksIndent5",
        --     "SnacksIndent6",
        --     "SnacksIndent7",
        --     "SnacksIndent8",
        -- },
      },
      scope = {
        enabled = true,
        animate = {
          enabled = true,
          easing = 'linear',
          duration = {
            step = 50, -- ms per step
            total = 300, -- maximum duration
          },
        },
        char = '│',
        underline = true, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = 'SnacksIndentScope', ---@type string|string[] hl group for scopes
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = false,
        -- only show chunk scopes in the current window
        only_current = false,
        hl = 'SnacksIndentChunk', ---@type string|string[] hl group for chunk scopes
        char = {
          corner_top = '┌',
          corner_bottom = '└',
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = '─',
          vertical = '│',
          arrow = '>',
        },
      },
      blank = {
        char = ' ',
        -- char = "·",
        hl = 'SnacksIndentBlank', ---@type string|string[] hl group for blank spaces
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
      end,
      priority = 200,
    },
    scope = {
      enabled = true,
      keys ={
        jump = {
          ["[["] = {
            bottom = false,
            edge = true,
            treesitter = { enabled = false },
            desc = "jump to top edge of scope",
          },
          ["]]"] = {
            bottom = true,
            edge = true,
            treesitter = { enabled = false },
            desc = "jump to bottom edge of scope",
          },
        },
      }
    },
    scroll = {
      animate = {
        duration = { step = 5, total = 50 },
        easing = 'linear',
      },
    },
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
    zen = {
      toggles = {
        dim = true,
        git_signs = true,
        mini_diff_signs = false,
        diagnostics = true,
        inlay_hints = true,
      },
      show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
      },
      win = { style = 'zen' },
      zoom = {
        toggles = {
          dim = true,
          git_signs = true,
          mini_diff_signs = false,
          diagnostics = true,
          inlay_hints = true,
        },
        show = {
          statusline = true,
          tabline = true,
        },
        win = {
          backdrop = false,
          width = 0, -- full width
        },
      },
    },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    { '<leader>bb', function() Snacks.scratch() end, desc = 'Snacks Scratch - Toggle Scratch Buffer' },
    { '<leader>bB', function() Snacks.scratch.select() end, desc = 'Snacks Scratch - Select Scratch Buffer' },
    { '<leader><BS>', function() Snacks.bufdelete() end, desc = 'Buffer - Delete Buffer' },
    { '<leader>dF', function() Snacks.rename.rename_file() end, desc = 'LSP - Rename File' },
    { '<leader>g<CR>', function() Snacks.gitbrowse() end, desc = 'Snacks Git - Browse' },
    -- { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    -- { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    -- { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    -- { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    -- { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    { '<BS>', function() Snacks.notifier.hide() end, desc = 'Snacks Notifier - Dismiss All' },
    { '<leader>,n', function() Snacks.notifier.show_history() end, desc = 'Snacks Notifier - Show History' },
    { '<leader>,p', function() Snacks.profiler.scratch() end, desc = 'Snacks Profiler - Scratch Buffer' },
    { ']r', function() Snacks.words.jump(vim.v.count1) end, desc = 'Snacks Words - Next Reference', mode = { 'n', 't' } },
    { '[r', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Snacks Words - Prev Reference', mode = { 'n', 't' } },
    { '<leader>,x', function() Snacks.dim() end, desc = 'Snacks Dim - Toggle Zen', mode = { 'n' } },
    { '<leader>,z', function() Snacks.zen.zen() end, desc = 'Snacks Zen - Toggle Zen', mode = { 'n' } },
    { '<leader>,Z', function() Snacks.zen.zoom() end, desc = 'Snacks Zen - Toggle Zoom', mode = { 'n' } },
    {
      '<leader>,<leader>',
        function() Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = { spell = false, wrap = false, signcolumn = 'yes', statuscolumn = ' ', conceallevel = 3 },
        } end,
      desc = 'Snacks Win - Neovim News',
    },
  },
  init = function()
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
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>z'
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>,S'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>,C'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>,B'
        Snacks.toggle.diagnostics():map '<leader>,D'
        Snacks.toggle.treesitter():map '<leader>,T'

        -- Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>,R'
        -- Snacks.toggle.line_number():map '<leader>,N'
        -- Snacks.toggle.inlay_hints():map '<leader>,I'
      end,
    })
  end,
}
