local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- BASH-style movement in insert mode
vim.api.nvim_set_keymap("i", "<C-a>", "<C-o>^", opts)
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>$", opts)

-- insert
map("i", "<C-;>", "<ESC>A;<ESC>", opts)
map("n", "<C-;>", "<ESC>A;<ESC>", opts)

-- === Navigate buffers ===
map("n", "<TAB>", "<cmd>bn<cr>")
map("n", "<S-TAB>", "<cmd>bp<cr>")

-- === Navigate tabs ===
map("n", "<leader>tc", "<cmd>tabnew<cr>")
map("n", "<leader>tn", "<cmd>tabnext<cr>")
map("n", "<leader>tp", "<cmd>tabprev<cr>")
map("n", "<leader>]", "<cmd>tabnext<cr>")
map("n", "<leader>[", "<cmd>tabprev<cr>")
map("i", "<C-t>", "<cmd>tabnext<cr>")
map("n", "<C-t>", "<cmd>tabnext<cr>")

-- === Close Buffer ===
map("n", "<leader>c", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Close Buffer" })

-- === Lazy ===
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- === Mason ===
map("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Mason" })

-- === LSP Trouble ===
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "TroubleToggle" })
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Trouble Workspace" })
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Trouble Document" })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Trouble loclist" })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Trouble quickfix" })
map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo" })

-- === neotree ===
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })
map("n", "<leader>oo", "<cmd>Neotree reveal toggle<CR>", { desc = "Toggle Reveal Explorer" })
map("n", "<leader>og", "<cmd>Neotree toggle git_status<CR>", { desc = "Toggle Git Status" })
map("n", "<leader>ob", "<cmd>Neotree toggle buffers<CR>", { desc = "Toggle Buffers" })
map("n", "<leader>of", "<cmd>NeoTreeFocus<CR>", { desc = "Focus" })

-- remap <c-s>
map("n", "<c-s>", function()
  require("flash").jump()
end, { desc = "Find Files" })
map("v", "<c-s>", function()
  require("flash").jump()
end, { desc = "Find Files" })
map("s", "<c-s>", function()
  require("flash").jump()
end, { desc = "Find Files" })

map("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Find Old Files" })

-- delete some keymaps
vim.api.nvim_del_keymap("n", "<leader>ww")
vim.api.nvim_del_keymap("n", "<leader>wd")
vim.api.nvim_del_keymap("n", "<leader>w-")
vim.api.nvim_del_keymap("n", "<leader>w|")
vim.api.nvim_del_keymap("n", "<leader>qq")
vim.api.nvim_del_keymap("n", "<leader>l")
vim.api.nvim_del_keymap("n", "<leader>cv")
