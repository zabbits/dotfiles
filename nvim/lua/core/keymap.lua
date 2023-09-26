local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local desc = function(val)
    return { noremap = true, silent = true, desc = val }
end

map("n", "<leader>e", function() require("oil").open() end, desc("Oil Open"))

-- === Window navigation ===
map('n', '<C-h>', '<C-w>h', opts);
map('n', '<C-l>', '<C-w>l', opts);
map('n', '<C-k>', '<C-w>k', opts);
map('n', '<C-j>', '<C-w>j', opts);


map("n", "<ESC>", "<cmd>nohlsearch<CR>", opts)
map("n", "<leader>w", "<cmd>w<CR>", desc("Save"))
map("n", "<leader>q", "<cmd>q<CR>", desc("Quit"))

map("i", ";;", "<ESC>A;<ESC>", opts)
