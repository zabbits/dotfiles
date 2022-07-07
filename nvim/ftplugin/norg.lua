vim.api.nvim_buf_set_keymap(0, 'n', 'K', ':lua require("nabla").popup()<CR>', {})
vim.api.nvim_buf_set_keymap(0, 'n', '<C-]>', ':Neorg toggle-concealer<CR>', {})
vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', ":ToggleConcealLevel<CR>", {})
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>nr', ':lua _G.snr.norg()<CR>', {})
