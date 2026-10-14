return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {}

    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    local cond = require 'nvim-autopairs.conds'

    -- Pair quotes only after whitespace, `=`, `,` or an opening bracket
    local chars = { '"', "'", '`' }

    for _, char in ipairs(chars) do
      for _, rule in ipairs(npairs.get_rules(char)) do
        rule:with_pair(cond.before_regex('[%s=,%(%[{]$', 1))
      end
    end

    -- A space typed inside (), [], {} or || gets a matching space before the closing character
    npairs.add_rules {
      Rule(' ', ' ')
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '[]', '{}', '||' }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key ' ',
    }

    -- Rust: pair <> after a type or path (`Vec<`, `Foo::<`) and || in closure position
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
