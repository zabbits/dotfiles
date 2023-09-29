-- === Window navigation ===
vim.z.map("n", "<C-h>", "<C-w>h")
vim.z.map("n", "<C-l>", "<C-w>l")
vim.z.map("n", "<C-k>", "<C-w>k")
vim.z.map("n", "<C-j>", "<C-w>j")

vim.z.map("n", "<ESC>", "nohlsearch")
vim.z.map("n", "<leader>w", "w", "Save")
vim.z.map("n", "<leader>q", "q", "Quit")

vim.z.map("i", ";;", "normal A;")
vim.z.map("i", ",,", "normal A,")

vim.z.map("n", "<leader>L", "Lazy", "Lazy");
