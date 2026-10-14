return {
  'chrishrb/gx.nvim',
  lazy=true,
  keys = { { 'g<CR>', '<cmd>Browse<cr>', mode = { 'n', 'x' }, desc = 'File - Open link under cursor' } },
  cmd = { 'Browse' },
  init = function()
    vim.g.netrw_nogx = 1
  end,
  submodules = false, -- Only gx's own tests use them
  config = function()
    require('gx').setup {
      open_browser_app = 'open',
      open_browser_args = { '--background' },
      handlers = {
        plugin = true,
        github = true,
        brewfile = true,
        package_json = true,
        search = true,
        go = true,
        -- Open the crate on the current Cargo.toml line in crates.io
        rust = {
          name = 'rust',
          filetype = { 'toml' },
          filename = 'Cargo.toml',
          handle = function(mode, line, _)
            local create = require('gx.helper').find(line, mode, '(%w+)%s-=%s')

            if create then
              return 'https://crates.io/crates/' .. create
            end
          end,
        },
      },
      handler_options = {
        search_engine = 'google',
        select_for_search = false, -- On a link, open it instead of asking whether to search the word
      },
    }
  end,
}
