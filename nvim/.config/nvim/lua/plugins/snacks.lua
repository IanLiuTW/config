---@diagnostic disable: undefined-global

-- stylua: ignore start
local dashboard_setup = {
  preset = {
    keys = {
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = ' ', key = '\\', desc = 'File Browser (Explorer)', action = ':lua Snacks.explorer()' },
      { icon = ' ', key = '-', desc = 'File Browser (Oil)', action = ':Oil --float' },
      { icon = ' ', key = 'r', desc = 'Restore CWD Session', action = ':SessionLoad' },
      { icon = ' ', key = '.', desc = 'Restore Last Session', action = ':SessionLoadLast' },
      { icon = '󱦞 ', key = 'p', desc = 'Select Project', action = ':lua Snacks.picker.projects()' },
      {
        text = { { '  ', hl = 'SnacksDashboardIcon' }, { 'Search File', hl = 'SnacksDashboardDesc', width = 50 }, { '󱁐  󱁐  f', hl = 'SnacksDashboardKey' }, },
        action = ":lua Snacks.dashboard.pick('files')",
      },
      {
        text = { { '  ', hl = 'SnacksDashboardIcon' }, { 'Search with Live Grep', hl = 'SnacksDashboardDesc', width = 50 }, { '󱁐  󱁐  g', hl = 'SnacksDashboardKey' }, },
        action = ":lua Snacks.dashboard.pick('live_grep')",
      },
      { icon = '󰘬 ', key = 'b', desc = 'Switch Branch', action = ':lua Snacks.picker.git_branches()' },
      { icon = ' ', key = 'g', desc = 'Open Neogit', action = ':Neogit' },
      { icon = '󰀬 ', key = 'm', desc = 'Open Mason', action = ':Mason' },
      { icon = '󰒲 ', key = ',', desc = 'Open Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      { icon = ' ', key = 'u', desc = 'Update Plugins', action = ':Lazy update' },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
    header = {
      { '         ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓        \n', hl = 'NeovimDashboardLogo1' },
      { '         ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒        \n', hl = 'NeovimDashboardLogo2' },
      { '        ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░        \n', hl = 'NeovimDashboardLogo3' },
      { '        ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██         \n', hl = 'NeovimDashboardLogo4' },
      { '        ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒        \n', hl = 'NeovimDashboardLogo5' },
      { '        ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░        ', hl = 'NeovimDashboardLogo6' },
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
      height = 11,
      padding = 1,
      ttl = 60,
      indent = 3,
    },
    {
      pane = 2,
      icon = ' ',
      title = 'Version',
      section = 'terminal',
      cmd = 'nvim --version | head -n 1',
      height = 1,
      padding = 1,
      ttl = 60,
      indent = 3,
    },
    { section = 'startup' },
  },
}
-- stylua: ignore end

local picker_setup = {
  ui_select = true,
  matcher = {
    fuzzy = true, -- use fuzzy matching
    smartcase = true, -- use smartcase
    ignorecase = true, -- use ignorecase
    sort_empty = false, -- sort results when the search string is empty
    filename_bonus = true, -- give bonus for matching file names (last part of the path)
    file_pos = true, -- support patterns like `file:line:col` and `file:line`
    -- the bonusses below, possibly require string concatenation and path normalization,
    -- so this can have a performance impact for large lists and increase memory usage
    cwd_bonus = false, -- give bonus for matching files in the cwd
    frecency = false, -- frecency bonus
    history_bonus = false, -- give more weight to chronological order
  },
  sort = {
    -- default sort is by score, text length and index
    fields = { 'score:desc', '#text', 'idx' },
  },
  previewers = {
    git = {
      native = true, -- use native (terminal) or Neovim for previewing git diffs and commits
    },
  },
  win = {
    -- input window
    input = {
      keys = {
        -- ["<Esc>"] = { "close", mode = { "n", "i" } }, -- to close the picker on ESC instead of going to normal mode
        ['<Esc>'] = 'close',
        ['<C-c>'] = { 'close', mode = 'i' },
        ['<CR>'] = { 'confirm', mode = { 'n', 'i' } },
        ['<S-CR>'] = { { 'pick_win', 'jump' }, mode = { 'n', 'i' } },
        ['<C-y>'] = { 'confirm', mode = { 'i', 'n' } },
        ['<c-e>'] = { 'confirm', mode = { 'i', 'n' } },
        ['<Space>'] = { 'select_and_next', mode = { 'i', 'n' } },
        ['<S-Space>'] = { 'select_and_prev', mode = { 'i', 'n' } },
        ['<C-,>'] = { 'history_back', mode = { 'i', 'n' } },
        ['<C-.>'] = { 'history_forward', mode = { 'i', 'n' } },
        ['<ScrollWheelDown>'] = { 'list_scroll_wheel_down', mode = { 'i', 'n' } },
        ['<ScrollWheelUp>'] = { 'list_scroll_wheel_up', mode = { 'i', 'n' } },
        ['<C-w>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
        ['<c-i>'] = { 'inspect', mode = { 'n', 'i' } },
        ['<c-1>'] = { 'toggle_ignored', mode = { 'i', 'n' } },
        ['<c-2>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
        ['<c-3>'] = { 'toggle_follow', mode = { 'i', 'n' } },
        ['<c-m>'] = { 'toggle_maximize', mode = { 'i', 'n' } },
        ['<c-g>'] = { 'toggle_live', mode = { 'i', 'n' } },
        ['<S-Tab>'] = { 'toggle_preview', mode = { 'i', 'n' } },
        ['<Tab>'] = { 'cycle_win', mode = { 'i', 'n' } },
        ['<c-a>'] = { 'select_all', mode = { 'n', 'i' } },
        ['<c-u>'] = { 'list_scroll_up', mode = { 'i', 'n' } },
        ['<c-d>'] = { 'list_scroll_down', mode = { 'i', 'n' } },
        ['<c-b>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
        ['<c-f>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
        ['<c-j>'] = { 'list_down', mode = { 'i', 'n' } },
        ['<c-k>'] = { 'list_up', mode = { 'i', 'n' } },
        ['<c-n>'] = { 'list_down', mode = { 'i', 'n' } },
        ['<c-p>'] = { 'list_up', mode = { 'i', 'n' } },
        ['<c-q>'] = { 'qflist', mode = { 'i', 'n' } },
        ['<c-s>'] = { 'edit_split', mode = { 'i', 'n' } },
        ['<c-t>'] = { 'tab', mode = { 'n', 'i' } },
        ['<c-v>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
        ['/'] = 'toggle_focus',
        ['?'] = 'toggle_help_input',
        ['G'] = 'list_bottom',
        ['gg'] = 'list_top',
        ['j'] = 'list_down',
        ['k'] = 'list_up',
        ['q'] = 'close',
        [':'] = { 'flash' },
        ['<c-;>'] = { 'flash', mode = { 'n', 'i' } },
      },
      b = {
        minipairs_disable = true,
      },
    },
    -- result list window
    list = {
      keys = {
        ['<Esc>'] = 'close',
        ['<2-LeftMouse>'] = 'confirm',
        ['<CR>'] = 'confirm',
        ['<S-CR>'] = { { 'pick_win', 'jump' } },
        ['<c-y>'] = { 'select_and_next', mode = { 'n', 'x' } },
        ['<c-e>'] = { 'select_and_prev', mode = { 'n', 'x' } },
        ['<ScrollWheelDown>'] = 'list_scroll_wheel_down',
        ['<ScrollWheelUp>'] = 'list_scroll_wheel_up',
        ['<c-i>'] = 'inspect',
        ['<c-1>'] = 'toggle_ignored',
        ['<c-2>'] = 'toggle_hidden',
        ['<c-3>'] = 'toggle_follow',
        ['<c-m>'] = 'toggle_maximize',
        ['<S-Tab>'] = 'toggle_preview',
        ['<Tab>'] = 'cycle_win',
        ['<c-a>'] = 'select_all',
        ['<c-u>'] = 'list_scroll_up',
        ['<c-d>'] = 'list_scroll_down',
        ['<c-b>'] = 'preview_scroll_up',
        ['<c-f>'] = 'preview_scroll_down',
        ['<c-p>'] = 'list_up',
        ['<c-n>'] = 'list_down',
        ['<c-k>'] = 'list_up',
        ['<c-j>'] = 'list_down',
        ['<c-s>'] = 'edit_split',
        ['<c-t>'] = 'tab',
        ['<c-v>'] = 'edit_vsplit',
        ['/'] = 'toggle_focus',
        ['?'] = 'toggle_help_list',
        ['G'] = 'list_bottom',
        ['gg'] = 'list_top',
        ['i'] = 'focus_input',
        ['j'] = 'list_down',
        ['k'] = 'list_up',
        ['q'] = 'close',
        ['zb'] = 'list_scroll_bottom',
        ['zt'] = 'list_scroll_top',
        ['zz'] = 'list_scroll_center',
        [':'] = { 'flash' },
        ['<c-;>'] = { 'flash', mode = { 'n', 'i' } },
      },
      wo = {
        conceallevel = 2,
        concealcursor = 'nvc',
      },
    },
    -- preview window
    preview = {
      keys = {
        ['<Esc>'] = 'close',
        ['q'] = 'close',
        ['i'] = 'focus_input',
        ['<ScrollWheelDown>'] = 'list_scroll_wheel_down',
        ['<ScrollWheelUp>'] = 'list_scroll_wheel_up',
        ['<Tab>'] = 'cycle_win',
      },
    },
  },
  sources = {
    buffers = {
      layout = {
        preset = 'dropdown',
      },
      win = {
        input = {
          keys = {
            ['x'] = 'bufdelete',
            ['<c-x>'] = { 'bufdelete', mode = { 'n', 'i' } },
          },
        },
        list = { keys = { ['x'] = 'bufdelete' } },
      },
    },
    colorschemes = {
      layout = {
        preset = 'ivy',
      },
    },
    grep = {
      hidden = true,
    },
    git_branches = {
      layout = {
        preset = 'ivy',
      },
    },
    files = {
      hidden = true,
      ignored = true,
      follow = true,
    },
    git_files = {
      hidden = true,
      untracked = true,
    },
    lines = {
      layout = {
        preset = 'default',
        preview = 'preview',
      },
    },
    git_log = {
      layout = { layout = { height = 0.95, width = 0.95 } },
    },
    git_log_file = {
      layout = { layout = { height = 0.95, width = 0.95 } },
    },
    explorer = {
      layout = {
        preview = { main = true, enabled = false },
      },
      win = {
        list = {
          keys = {
            ['l'] = 'confirm',
            ['h'] = 'explorer_close',
            ['u'] = 'explorer_update',
            ['O'] = 'explorer_open', -- open with system application
            ['<S-Tab>'] = 'toggle_preview',
            ['a'] = 'explorer_add',
            ['d'] = 'explorer_del',
            ['r'] = 'explorer_rename',
            ['c'] = 'explorer_copy',
            ['m'] = 'explorer_move',
            ['y'] = 'explorer_yank',
            ['H'] = 'explorer_up',
            ['L'] = 'explorer_focus',
            ['.'] = 'explorer_cd',
            [']g'] = 'explorer_git_next',
            ['[g'] = 'explorer_git_prev',
            ['<c-1>'] = 'toggle_ignored',
            ['<c-2>'] = 'toggle_hidden',
            ['<c-c>'] = 'explorer_close_all',
          },
        },
      },
    },
  },
  actions = {
    flash = function(picker)
      require('flash').jump {
        pattern = '^',
        label = { after = { 0, 0 } },
        search = {
          mode = 'search',
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
            end,
          },
        },
        action = function(match)
          local idx = picker.list:row2idx(match.pos[1])
          picker.list:_move(idx, true, true)
        end,
      }
    end,
  },
}

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    animation = {
      fps = 100, -- frames per second. Global setting for all animations
    },
    bigfile = {
      enabled = true,
    },
    picker = picker_setup,
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    -- dashboard = dashboard_setup,
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = {
      enabled = true,
    },
    -- input = { enabled = true },
    image = { enabled = true },
    indent = {
      indent = {
        char = '│',
        blank = ' ',
        -- blank = "∙",
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = 'SnacksIndent', ---@type string|string[] hl groups for indent guides
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
    gitbrowse = {},
    lazygit = {
      enabled = true,
      configure = false,
      theme = {
        selectedLineBgColor = { bg = 'black' },
      },
      win = {
        position = 'float',
        backdrop = 60,
        height = 0.96,
        width = 0.98,
        zindex = 50,
      },
    },
    gh = {
      enabled = true,
    },
    scope = {
      enabled = true,
      keys = {
        jump = {
          ['[['] = {
            bottom = false,
            edge = true,
            treesitter = { enabled = false },
            desc = 'jump to top edge of scope',
          },
          [']]'] = {
            bottom = true,
            edge = true,
            treesitter = { enabled = false },
            desc = 'jump to bottom edge of scope',
          },
        },
      },
    },
    scroll = {
      animate = {
        duration = { step = 5, total = 50 },
        easing = 'linear',
      },
    },
    statuscolumn = {
      left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
      right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
      refresh = 50, -- refresh at most every 50ms },
    },
    words = {
      enabled = true,
    },
    zen = {
      toggles = {
        dim = false,
        git_signs = true,
        mini_diff_signs = false,
        diagnostics = true,
        inlay_hints = true,
      },
      show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
      },
      win = { style = 'zen', width = 0.6 },
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
    terminal = {},
  },
  -- stylua: ignore start
  keys = {
    -- Picker
    { "<leader><tab>", function() Snacks.picker.buffers() end, desc = "Picker - Buffers" },
    { "<leader><leader>:", function() Snacks.picker.command_history() end, desc = "Picker - Command History" },
    { "<leader><leader>,", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Picker - Find Config File" },
    { "<leader><leader>F", function() Snacks.picker.files() end, desc = "Picker - Find Files" },
    { "<leader><leader>f", function() Snacks.picker.git_files() end, desc = "Picker - Find Git Files" },
    { "<leader><leader>.", function() Snacks.picker.recent() end, desc = "Picker - Recent" },
    -- -- git
    { "<leader>gl", function() Snacks.picker.git_log_file() end, desc = "Picker - Git Log File" },
    { "<leader>gL", function() Snacks.picker.git_log() end, desc = "Picker - Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Picker - Git Status" },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Picker - Git Branches" },
    { "<leader>gz", function() Snacks.picker.git_stash() end, desc = "Picker - Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Picker - Git Diff" },
    -- -- grep
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Picker - Buffer Lines" },
    { "<leader><leader>/", function() Snacks.picker.grep_buffers() end, desc = "Picker - Grep Open Buffers" },
    { "<leader><leader>g", function() Snacks.picker.grep() end, desc = "Picker - Grep" },
    { "<leader><leader>G", function() Snacks.picker.grep_word() end, desc = "Picker - Grep Word", mode = { "n", "x" } },
    -- -- search
    { "<leader><leader>r", function() Snacks.picker.resume() end, desc = "Picker - Resume" },
    { "<leader><leader>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Picker - Diagnostics Buffer" },
    { "<leader><leader>D", function() Snacks.picker.diagnostics() end, desc = "Picker - Diagnostics" },
    { "<leader><leader>h", function() Snacks.picker.highlights() end, desc = "Picker - Highlights" },
    { "<leader><leader>m", function() Snacks.picker.marks() end, desc = "Picker - Marks" },
    { "<leader><leader>z", function() Snacks.picker.zoxide() end, desc = "Zoxide" },
    { "<leader><leader>c", function() Snacks.picker.colorschemes() end, desc = "Picker - Colorschemes" },
    { "<leader><leader>i", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader><leader>n", function() Snacks.picker.notifications() end, desc = "Picker - Notifications" },
    { "<leader><leader><leader>", function() Snacks.picker.pickers() end, desc = "Picker - Pickers" },
    { "<leader><leader>p", function() Snacks.picker.projects() end, desc = "Picker - Projects" },
    { "<leader><leader>;", function() Snacks.picker.todo_comments() end, desc = "Picker - Todo" },
    { "<leader><leader>:", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Picker - Todo/Fix/Fixme" },
    { "<leader><leader>j", function() Snacks.picker.jumps() end, desc = "Picker - Jumps" },
    { "<leader><leader>l", function() Snacks.picker.loclist() end, desc = "Picker - Location List" },
    { "<leader><leader>q", function() Snacks.picker.qflist() end, desc = "Picker - Quickfix List" },
    { "<leader><leader>u", function() Snacks.picker.undo() end, desc = "Picker - Undo" },
    { "<leader><leader>s", function() Snacks.picker.spelling() end, desc = "Picker - Spelling" },
    -- -- search - advanced
    { "<leader><leader>K", function() Snacks.picker.keymaps() end, desc = "Picker - Keymaps" },
    { "<leader><leader>M", function() Snacks.picker.man() end, desc = "Picker - Man Pages" },
    { '<leader><leader>"', function() Snacks.picker.registers() end, desc = "Picker - Registers" },
    { "<leader><leader>A", function() Snacks.picker.autocmds() end, desc = "Picker - Autocmds" },
    { "<leader><leader>C", function() Snacks.picker.commands() end, desc = "Picker - Commands" },
    { "<leader><leader>?", function() Snacks.picker.help() end, desc = "Picker - Help Pages" },
    { "<leader><leader>L", function() Snacks.picker.Lazy() end, desc = "Picker - Lazy Packages" },
    -- Picker - LSP
    { "<leader>D", function() Snacks.picker.lsp_definitions() end, desc = "LSP - Goto Definition" },
    { "<leader>dD", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP - Goto T[y]pe Definition" },
    { "<leader>dr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP - References" },
    { "<leader>di", function() Snacks.picker.lsp_implementations() end, desc = "LSP - Goto Implementation" },
    { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "LSP - Symbols" },
    { "<leader>dS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP - Workspace Symbols" },
    -- Rename
    { '<leader>dF', function() Snacks.rename.rename_file() end, desc = 'LSP - Rename File' },
    -- Buffer
    { '<C-BS>', function() Snacks.bufdelete() end, desc = 'Buffer - Delete Buffer' },
    -- Scratch
    { '<leader>bb', function() Snacks.scratch() end, desc = 'Scratch - Toggle Scratch Buffer' },
    { '<leader>bB', function() Snacks.scratch.select() end, desc = 'Scratch - Select Scratch Buffer' },
    -- Git
    { '<leader>g<CR>', function() Snacks.gitbrowse() end, desc = 'Git - Browse' },
    -- { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    -- Notifier
    { '<BS>', function() Snacks.notifier.hide() end, desc = 'Notifier - Dismiss All' },
    { '<leader>,n', function() Snacks.notifier.show_history() end, desc = 'Notifier - Show History' },
    -- Profiler
    { '<leader>,p', function() Snacks.profiler.scratch() end, desc = 'Profiler - Scratch Buffer' },
    -- Words
    { ']r', function() Snacks.words.jump(vim.v.count1) end, desc = 'Words - Next Reference', mode = { 'n', 't' } },
    { '[r', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Words - Prev Reference', mode = { 'n', 't' } },
    -- Dim
    { '<leader>,x', function() Snacks.dim() end, desc = 'Dim - Toggle Zen', mode = { 'n' } },
    -- Zen
    { '<leader>,z', function() Snacks.zen.zen() end, desc = 'Zen - Toggle Zen', mode = { 'n' } },
    { '<leader>,Z', function() Snacks.zen.zoom() end, desc = 'Zen - Toggle Zoom', mode = { 'n' } },
    -- Explorer
    { '\\', function() Snacks.explorer() end, desc = 'Explorer - Toggle Explorer', mode = { 'n' } },
    -- Terminal
    { "<c-/>",          function() Snacks.terminal() end, desc = "Terminal - Toggle", mode = { 'n', 't'} },
    { "<leader>-",      function() Snacks.terminal.open(nil, { win = { position = "right", width = 0.25 } }) end, desc = "Terminal - Horizontal Split" },
    { "<leader>=",      function() Snacks.terminal.open(nil, { win = { position = "bottom", height = 0.25 } }) end, desc = "Terminal - Vertical Split" },
    -- Github
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gr", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gR", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
    -- LazyGit
    { "<leader>gG", function() Snacks.lazygit() end, desc = "Lazygit - Toggle" },
    -- News
    {
      '<leader>,?',
        function() Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.8,
          height = 0.8,
          wo = { spell = false, wrap = false, signcolumn = 'yes', statuscolumn = ' ', conceallevel = 3 },
        } end,
      desc = 'Win - Neovim News',
    },
  },
  -- stylua: ignore end
  init = function()
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
        -- Snacks.toggle.treesitter():map '<leader>,T'
        -- Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>,R'
        -- Snacks.toggle.line_number():map '<leader>,N'
        -- Snacks.toggle.inlay_hints():map '<leader>,I' -- LSP has this function
      end,
    })
  end,
}
