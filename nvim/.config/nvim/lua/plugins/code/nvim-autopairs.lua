return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {}

    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    local cond = require 'nvim-autopairs.conds'

    local chars = { '"', "'", '`' }

    for _, char in ipairs(chars) do
      local rule = npairs.get_rule(char)[1]

      if rule then
        rule:with_pair(cond.before_regex('[%s=,%(%[{]$', 1))
      end
    end

    npairs.add_rules {
      Rule(' ', ' ')
        :with_pair(function(opts)
          -- Get the two characters around the cursor
          local pair = opts.line:sub(opts.col - 1, opts.col)
          -- Check if we are inside any of these pairs
          return vim.tbl_contains({ '()', '[]', '{}', '||' }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key ' ',
    }

    npairs.add_rule(Rule('<', '>', {
      'rust',
    }):with_pair(cond.before_regex('%a+:?:?$', 3)):with_move(function(opts)
      return opts.char == '>'
    end))

    npairs.add_rule(Rule('|', '|', { 'rust' }):with_pair(cond.before_regex('[%(=,]%s*$', 2)):with_move(function(opts)
      return opts.char == '|'
    end))
  end,
}
