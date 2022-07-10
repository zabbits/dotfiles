vim.api.nvim_buf_set_keymap(0, 'n', 'K', ':lua require("nabla").popup()<CR>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-]>', ':Neorg toggle-concealer<CR>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', ":ToggleConcealLevel<CR>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>nr', ':lua _G.snr.norg()<CR>', { noremap = true, silent = true })
