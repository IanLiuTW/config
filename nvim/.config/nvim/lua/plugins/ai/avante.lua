return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- set this if you want to always pull the latest change
  opts = {
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    provider = 'copilot', -- Recommend using Claude
    auto_suggestions_provider = 'copilot', -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
    providers = {
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-3-5-sonnet-20241022',
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },
    --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
    ---Note: This is an experimental feature and may not work as expected.
    dual_boost = {
      enabled = false,
      first_provider = 'openai', --first_provider: The first provider to generate response. Default to "openai".
      second_provider = 'claude', --second_provider: The second provider to generate response. Default to "claude".
      prompt = 'Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]',
      timeout = 60000, -- Timeout in milliseconds. Default to 60000.
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },
    mappings = {
      ---@class AvanteConflictMappings
      diff = {
        ours = 'go',
        theirs = 'gt',
        all_theirs = 'gT',
        both = 'ga',
        cursor = 'gy',
        prev = '[x',
        next = ']x',
      },
      suggestion = {
        accept = '<C-CR>',
        prev = '<C-,>',
        next = '<C-.>',
        dismiss = '<C-e>',
      },
      jump = {
        prev = '<C-B>',
        next = '<C-F>',
      },
      submit = {
        normal = '<CR>',
        insert = '<S-CR>',
      },
      ask = '<C-q>A',
      new_ask = '<C-q>N',
      edit = '<C-q>E',
      refresh = '<C-q>R',
      focus = '<C-q>F',
      stop = '<C-q>>',
      toggle = {
        default = '<C-q><S-Tab>',
        debug = '<C-q>D',
        hint = '<C-q>H',
        suggestion = '<C-q>S',
        repomap = '<C-q>M',
      },
      sidebar = {
        apply_all = 'A',
        apply_cursor = 'a',
        switch_windows = '<Tab>',
        reverse_switch_windows = '<S-Tab>',
        retry_user_request = 'r',
        edit_user_request = 'e',
        remove_file = 'd',
        add_file = '@',
        close = { 'q' },
        close_from_input = { normal = 'q', insert = '<C-c>' },
      },
      files = {
        add_current = '<C-q>C', -- Add current buffer to selected files
        add_all_buffers = '<C-q>B', -- Add all buffer files to selected files
      },
      select_model = '<C-q>?', -- Select model command
      select_history = '<C-q><', -- Select history command
    },
    hints = { enabled = false },
    windows = {
      --   ---@type "right" | "left" | "top" | "bottom"
      --   position = 'right', -- the position of the sidebar
      --   wrap = true, -- similar to vim.o.wrap
      --   width = 30, -- default % based on available width
      --   sidebar_header = {
      --     enabled = true, -- true, false to enable/disable the header
      --     align = 'center', -- left, center, right for title
      --     rounded = true,
      --   },
      --   edit = {
      --     border = 'rounded',
      --     start_insert = true, -- Start insert mode when opening the edit window
      --   },
      ask = {
        floating = false, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = false, -- Start insert mode when opening the ask window
        border = 'rounded',
        ---@type "ours" | "theirs"
        focus_on_apply = 'ours', -- which diff to focus after applying
      },
    },
    -- highlights = {
    --   ---@type AvanteConflictHighlights
    --   diff = {
    --     current = 'DiffText',
    --     incoming = 'DiffAdd',
    --   },
    -- },
    -- --- @class AvanteConflictUserConfig
    -- diff = {
    --   autojump = true,
    --   ---@type string | fun(): any
    --   list_opener = 'copen',
    --   --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
    --   --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
    --   --- Disable by setting to -1.
    --   override_timeoutlen = 500,
    -- },
  },
  keys = {
    {
      '<leader>P',
      function()
        return vim.bo.filetype == 'AvanteInput' and require('avante.clipboard').paste_image() or require('img-clip').paste_image()
      end,
      desc = 'Img-Clip: Paste Image',
    },
  },
  config = function(_, opts)
    require('avante').setup(opts)

    vim.keymap.set('n', '<C-q>G', function()
      local prompt =
        'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit. Be concise and only generate the commit messages. Do not include prompt details nor the results of git diff.'
      local diffs = table.concat(vim.fn.systemlist 'git diff --cached', ' ')
      vim.cmd(':AvanteAsk ' .. prompt .. ' The results of git diff: ' .. diffs)
    end, { desc = 'avante: Generate git commit message (staged files)' })
  end,
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    'MeanderingProgrammer/render-markdown.nvim',
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}
