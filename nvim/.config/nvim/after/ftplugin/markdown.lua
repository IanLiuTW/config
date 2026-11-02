-- Continue `-`, `*`, `+` bullets and `>` quotes on <CR> and `o`/`O`.
-- The runtime ftplugin uses `fb:` (first line only), which keeps the indent but drops the marker.
vim.opt_local.comments = { 'b:-', 'b:*', 'b:+', 'n:>' }
vim.opt_local.formatoptions:append 'ro'
