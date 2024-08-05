vim.api.nvim_set_keymap("n", "q", ":lua require('curl').close_curl_tab()<CR>", { noremap = true, silent = true })
