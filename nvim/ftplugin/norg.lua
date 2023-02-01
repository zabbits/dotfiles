vim.api.nvim_buf_set_keymap(0, 'n', 'K', ':lua require("nabla").popup()<CR>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-]>', ':Neorg toggle-concealer<CR>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', ":ToggleConcealLevel<CR>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'i', '<C-e>', '<cmd>Neorg keybind norg core.looking-glass.magnify-code-block<CR>', { noremap = true, silent = true })
