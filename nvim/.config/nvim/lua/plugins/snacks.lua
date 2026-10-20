---@diagnostic disable: undefined-global

local picker_setup = {
  ui_select = true,
  matcher = {
    fuzzy = true,
    smartcase = true,
    ignorecase = true,
    sort_empty = false,
    filename_bonus = true,
    file_pos = true,
    -- These bonuses cost time and memory on large lists
    cwd_bonus = false,
    frecency = false,
    history_bonus = false,
  },
  sort = {
    fields = { 'score:desc', '#text', 'idx' },
  },
  previewers = {
    git = {
      native = true, -- Render git diffs and commits in the terminal, not in Neovim
    },
  },
  win = {
    input = {
      keys = {
        ['<Esc>'] = 'close',
        ['<C-c>'] = { 'close', mode = 'i' },
        ['<CR>'] = { 'confirm', mode = { 'i', 'n' } },
        ['<S-CR>'] = { { 'pick_win', 'jump' }, mode = { 'n', 'i' } },
        ['<c-e>'] = { 'select_and_next', mode = { 'i', 'n' } },
        ['<c-y>'] = { 'select_and_prev', mode = { 'i', 'n' } },
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
        ['\''] = { 'flash' },
        ['<c-\'>'] = { 'flash', mode = { 'n', 'i' } },
      },
      b = {
        minipairs_disable = true,
      },
    },
    list = {
      keys = {
        ['<Esc>'] = 'close',
        ['<2-LeftMouse>'] = 'confirm',
        ['<CR>'] = 'confirm',
        ['<S-CR>'] = { { 'pick_win', 'jump' } },
        ['<c-e>'] = { 'select_and_next', mode = { 'n', 'x' } },
        ['<c-y>'] = { 'select_and_prev', mode = { 'n', 'x' } },
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
            ['O'] = 'explorer_open',
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
      fps = 100,
    },
    bigfile = {
      enabled = true,
    },
    picker = picker_setup,
    explorer = {
      enabled = true,
      replace_netrw = false, -- Oil owns directory buffers
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = {
      enabled = true,
    },
    image = { enabled = true },
    indent = {
      indent = {
        char = '│',
        blank = ' ',
        only_scope = false,
        only_current = false,
        hl = 'SnacksIndent',
      },
      scope = {
        enabled = true,
        animate = {
          enabled = true,
          easing = 'linear',
          duration = {
            step = 50,
            total = 300,
          },
        },
        char = '│',
        underline = true,
        only_current = false,
        hl = 'SnacksIndentScope',
      },
      chunk = {
        enabled = true,
        only_current = false,
        hl = 'SnacksIndentChunk',
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = '─',
          vertical = '│',
          arrow = '─',
        },
      },
      blank = {
        char = ' ',
        hl = 'SnacksIndentBlank',
      },
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
      end,
      priority = 200,
    },
    gitbrowse = {},
    lazygit = {
      enabled = true,
      configure = false,
      win = {
        position = 'float',
        backdrop = 60,
        height = 0.96,
        width = 0.98,
        zindex = 50,
        -- Let lazygit's move-commit keys through the global terminal window maps
        keys = {
          lg_down = { '<C-j>', '<C-j>', mode = 't', expr = true },
          lg_up = { '<C-k>', '<C-k>', mode = 't', expr = true },
        },
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
      left = { 'mark', 'sign' },
      right = { 'fold', 'git' },
      folds = {
        open = false,
        git_hl = false,
      },
      git = {
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
      refresh = 50,
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
        statusline = false,
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
          width = 0, -- 0 means full width
        },
      },
    },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
    terminal = {},
  },
  -- stylua: ignore start
  keys = {
    -- Picker
    { "<leader><tab>", function() Snacks.picker.buffers() end, desc = "Picker - Buffers" },
    { "<leader><leader>:", function() Snacks.picker.command_history() end, desc = "Picker - Command history" },
    { "<leader><leader>,", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Picker - Config files" },
    { "<leader><leader>F", function() Snacks.picker.files() end, desc = "Picker - All files" },
    { "<leader><leader>f", function() Snacks.picker.git_files() end, desc = "Picker - Git files" },
    { "<leader><leader>.", function() Snacks.picker.recent() end, desc = "Picker - Recent files" },
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Picker - Buffer lines" },
    { "<leader><leader>/", function() Snacks.picker.grep_buffers() end, desc = "Picker - Grep open buffers" },
    { "<leader><leader>g", function() Snacks.picker.grep() end, desc = "Picker - Grep" },
    { "<leader><leader>G", function() Snacks.picker.grep_word() end, desc = "Picker - Grep word", mode = { "n", "x" } },
    { "<leader><leader>r", function() Snacks.picker.resume() end, desc = "Picker - Resume" },
    { "<leader><leader>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Picker - Diagnostics (buffer)" },
    { "<leader><leader>D", function() Snacks.picker.diagnostics() end, desc = "Picker - Diagnostics (all)" },
    { "<leader><leader>h", function() Snacks.picker.highlights() end, desc = "Picker - Highlights" },
    { "<leader><leader>m", function() Snacks.picker.marks() end, desc = "Picker - Marks" },
    { "<leader><leader>z", function() Snacks.picker.zoxide() end, desc = "Picker - Zoxide" },
    { "<leader><leader>c", function() Snacks.picker.colorschemes() end, desc = "Picker - Colorschemes" },
    { "<leader><leader>i", function() Snacks.picker.icons() end, desc = "Picker - Icons" },
    { "<leader><leader>n", function() Snacks.picker.notifications() end, desc = "Picker - Notifications" },
    { "<leader><leader><leader>", function() Snacks.picker.pickers() end, desc = "Picker - Pickers" },
    { "<leader><leader>p", function() Snacks.picker.projects() end, desc = "Picker - Projects" },
    { "<leader><leader>;", function() Snacks.picker.todo_comments() end, desc = "Picker - Todo comments" },
    { "<leader><leader>'", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Picker - Todo / Fix / Fixme" },
    { "<leader><leader>j", function() Snacks.picker.jumps() end, desc = "Picker - Jumps" },
    { "<leader><leader>l", function() Snacks.picker.loclist() end, desc = "Picker - Location list" },
    { "<leader><leader>q", function() Snacks.picker.qflist() end, desc = "Picker - Quickfix list" },
    { "<leader><leader>u", function() Snacks.picker.undo() end, desc = "Picker - Undo history" },
    { "<leader><leader>s", function() Snacks.picker.spelling() end, desc = "Picker - Spelling" },
    { "<leader><leader>K", function() Snacks.picker.keymaps() end, desc = "Picker - Keymaps" },
    { "<leader><leader>M", function() Snacks.picker.man() end, desc = "Picker - Man pages" },
    { '<leader><leader>"', function() Snacks.picker.registers() end, desc = "Picker - Registers" },
    { "<leader><leader>A", function() Snacks.picker.autocmds() end, desc = "Picker - Autocmds" },
    { "<leader><leader>C", function() Snacks.picker.commands() end, desc = "Picker - Commands" },
    { "<leader><leader>?", function() Snacks.picker.help() end, desc = "Picker - Help pages" },
    { "<leader><leader>L", function() Snacks.picker.lazy() end, desc = "Picker - Lazy plugin specs" },
    -- Code (LSP)
    { "<leader>cd", function() Snacks.picker.lsp_definitions() end, desc = "Code - Definition" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Code - Definition" },
    { "<leader>ct", function() Snacks.picker.lsp_type_definitions() end, desc = "Code - Type definition" },
    { "<leader>cr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Code - References" },
    { "<leader>ci", function() Snacks.picker.lsp_implementations() end, desc = "Code - Implementation" },
    { "<leader>cs", function() Snacks.picker.lsp_symbols() end, desc = "Code - Symbols" },
    { "<leader>cS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Code - Workspace symbols" },
    { '<leader>cN', function() Snacks.rename.rename_file() end, desc = 'Code - Rename file' },
    -- Buffer
    { '<C-BS>', function() Snacks.bufdelete() end, desc = 'Buffer - Close (keep layout)' },
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Buffer - Close (keep layout)' },
    { '<leader>bD', function() Snacks.bufdelete({ force = true }) end, desc = 'Buffer - Force close (keep layout)' },
    { '<C-S-BS>', '<Cmd>tabclose<CR>', noremap = true, silent = true, desc = 'Tab - Close' },
    { '<leader>bb', function() Snacks.scratch() end, desc = 'Buffer - Toggle scratch buffer' },
    { '<leader>bB', function() Snacks.scratch.select() end, desc = 'Buffer - Select scratch buffer' },
    -- Git
    { '<leader>g<CR>', function() Snacks.gitbrowse() end, desc = 'Git - Open in browser' },
    { '<leader>g<S-CR>', function() Snacks.gitbrowse({branch = "master"}) end, desc = 'Git - Open in browser (master)' },
    { "<leader>gl", function() Snacks.picker.git_log_file() end, desc = "Git - Log (file)" },
    { "<leader>gL", function() Snacks.picker.git_log() end, desc = "Git - Log (repo)" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git - Status" },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git - Branches" },
    { "<leader>gz", function() Snacks.picker.git_stash() end, desc = "Git - Stash (picker)" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git - Diff (picker)" },
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "Git - GitHub issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "Git - GitHub issues (all)" },
    { "<leader>gr", function() Snacks.picker.gh_pr() end, desc = "Git - GitHub pull requests (open)" },
    { "<leader>gR", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "Git - GitHub pull requests (all)" },
    { "<leader>gG", function() Snacks.lazygit() end, desc = "Git - Lazygit" },
    { "<leader>hb", function() Snacks.git.blame_line() end, desc = "Hunk - Blame line" },
    -- Notifications
    { '<BS>', function() Snacks.notifier.hide() end, desc = 'Notifications - Dismiss all' },
    { '<leader>,n', function() Snacks.notifier.show_history() end, desc = 'Tools - Notification history' },
    { '<leader>,p', function() Snacks.profiler.scratch() end, desc = 'Tools - Profiler' },
    -- References under the cursor
    { ']r', function() Snacks.words.jump(vim.v.count1) end, desc = 'Code - Next reference' },
    { '[r', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Code - Previous reference' },
    -- Window
    { '<C-w><CR>', function() Snacks.zen.zoom() end, desc = 'Window - Zoom', mode = { 'n' } },
    -- Explorer
    { '\\', function() Snacks.explorer() end, desc = 'Explorer - Toggle', mode = { 'n' } },
    -- Terminal
    { "<c-/>",          function() Snacks.terminal() end, desc = "Terminal - Toggle", mode = { 'n', 't'} },
    { "<leader>-",      function() Snacks.terminal.open(nil, { win = { position = "bottom", height = 0.25 } }) end, desc = "Terminal - Bottom" },
    { "<leader>|",      function() Snacks.terminal.open(nil, { win = { position = "right", width = 0.25 } }) end, desc = "Terminal - Right" },
    -- News
    {
      '<leader>,?',
        function() Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.8,
          height = 0.8,
          wo = { spell = false, wrap = false, signcolumn = 'yes', statuscolumn = ' ', conceallevel = 3 },
        } end,
      desc = 'Tools - Neovim news',
    },
  },
  -- stylua: ignore end
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Debug helpers: dd() inspects values, bt() prints a backtrace
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- `:=` prints through Snacks

        -- UI toggles live under <leader>u; which-key shows each one's state
        local ts_indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        local severity = vim.diagnostic.severity
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark background' }):map '<leader>ub'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'Conceal' }):map '<leader>uc'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.inlay_hints():map '<leader>ui'
        Snacks.toggle
          .new({
            id = 'virtual_lines',
            name = 'Virtual lines',
            get = function()
              return vim.diagnostic.config().virtual_lines and true or false
            end,
            set = function(state)
              vim.diagnostic.config { virtual_lines = state }
            end,
          })
          :map '<leader>ul'
        Snacks.toggle
          .new({
            id = 'virtual_text_hints',
            name = 'Hints in virtual text',
            get = function()
              local vt = vim.diagnostic.config().virtual_text
              return type(vt) == 'table' and type(vt.severity) == 'table' and vt.severity.min == severity.HINT
            end,
            set = function(state)
              -- Replace only virtual_text.severity, keeping source/spacing
              local min = state and severity.HINT or severity.INFO
              vim.diagnostic.config { virtual_text = vim.tbl_extend('force', vim.diagnostic.config().virtual_text or {}, { severity = { min = min } }) }
            end,
          })
          :map '<leader>uv'
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.treesitter():map '<leader>ut'
        Snacks.toggle
          .new({
            id = 'treesitter_indent',
            name = 'Treesitter indent',
            get = function()
              return vim.bo.indentexpr == ts_indentexpr
            end,
            set = function(state)
              vim.bo.indentexpr = state and ts_indentexpr or ''
            end,
          })
          :map '<leader>u='
        Snacks.toggle.dim():map '<leader>ux'
        Snacks.toggle.zen():map '<leader>uz'
        Snacks.toggle.zoom():map '<leader>uZ'
        for _, t in ipairs {
          { key = 'l', field = 'linehl', name = 'Git line highlight' },
          { key = 'b', field = 'current_line_blame', name = 'Git line blame' },
          { key = 'w', field = 'word_diff', name = 'Git word diff' },
        } do
          Snacks.toggle
            .new({
              id = 'gitsigns_' .. t.field,
              name = t.name,
              get = function()
                return require('gitsigns.config').config[t.field]
              end,
              set = function(state)
                require('gitsigns')['toggle_' .. t.field](state)
              end,
            })
            :map('<leader>ug' .. t.key)
        end
      end,
    })
  end,
}
