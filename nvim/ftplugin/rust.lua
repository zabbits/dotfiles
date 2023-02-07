vim.api.nvim_buf_set_keymap(0, 'n', '<C-m>', ":lua require'rust-tools'.hover_actions.hover_actions()<CR>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>R', "<cmd>RustRun<CR>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', "<cmd>RustRunnables<CR>", { noremap = true, silent = true })
