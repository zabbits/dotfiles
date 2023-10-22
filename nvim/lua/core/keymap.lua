-- === Window navigation ===
vim.z.mapo("n", "<C-h>", "<C-w>h")
vim.z.mapo("n", "<C-l>", "<C-w>l")
vim.z.mapo("n", "<C-k>", "<C-w>k")
vim.z.mapo("n", "<C-j>", "<C-w>j")

vim.z.map("n", "<ESC>", "nohlsearch")
vim.z.map("n", "<leader>w", "w", "Save")
vim.z.map("n", "<leader>q", "q", "Quit")

vim.z.map("n", "<leader>L", "Lazy", "Lazy")
