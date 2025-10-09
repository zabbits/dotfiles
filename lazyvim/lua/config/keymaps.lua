-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del('n', '<leader>wd')
vim.keymap.del('n', '<leader>wm')

vim.keymap.del('n', '<leader>qq')

vim.keymap.set("n", "<leader>q", "<CMD>qall<CR>")
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>")
