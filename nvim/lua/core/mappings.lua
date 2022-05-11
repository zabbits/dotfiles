local M = {}

local utils = require "core.utils"

local map = vim.keymap.set
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local opts = { noremap = true, silent = true }

-- vim.keymap.set did not work for this
map("", "<Space>", "<Nop>", opts)
--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--========================= Normal ==========================--

-- ESC cancel higlight
map("n", "<ESC>", ":nohlsearch<CR>", opts)
map("x", "J", "<cmd>move '>+1<CR>gv-gv")
map("x", "K", "<cmd>move '<-2<CR>gv-gv")

-- disable Ex mode:
map("n", "Q", "<Nop>")

-- insert current time
map("n", "<A-i>", ":put =strftime('%Y-%m-%d %H:%M:%S')<CR>", opts)

if utils.is_available "smart-splits.nvim" then
  -- Better window navigation
  local ss = require("smart-splits")
  map("n", "<A-h>", ss.resize_left)
  map("n", "<A-j>", ss.resize_down)
  map("n", "<A-k>", ss.resize_up)
  map("n", "<A-l>", ss.resize_right)
  -- moving between splits
  map('n', '<C-h>', ss.move_cursor_left)
  map('n', '<C-j>', ss.move_cursor_down)
  map('n', '<C-k>', ss.move_cursor_up)
  map('n', '<C-l>', ss.move_cursor_right)
end

-- Navigate buffers
if utils.is_available "bufferline.nvim" then
  map("n", "]]", "<cmd>BufferLineCycleNext<cr>")
  map("n", "[[", "<cmd>BufferLineCyclePrev<cr>")
else
  map("n", "]]", "<cmd>bnext<CR>")
-- Normal Leader Mappings --
  map("n", "[[", "<cmd>bprevious<CR>")
end

-- LSP
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gd", vim.lsp.buf.definition, { desc = "Show the definition of current function" })
map("n", "gI", vim.lsp.buf.implementation)
map("n", "go", vim.diagnostic.open_float)
map("n", "gl", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "gk", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "gj", vim.diagnostic.goto_next)
map("n", "K", vim.lsp.buf.hover)
-- <leader>rn: legacy binding here for backwards compatibility but not in which-key (see <leader>lr)
map("n", "<leader>rn", vim.lsp.buf.rename)

-- code action menu
map("n", "<leader>xa", "<cmd>CodeActionMenu<CR>")

-- lsp symbols
if utils.is_available "symbols-outline.nvim" then
  map("n", "gs", "<cmd>SymbolsOutline<CR>")
end

-- lsp trouble
if utils.is_available "trouble.nvim" then
  map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
  map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
  map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
  map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
  map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
  map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})
  map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})
end

-- lsp preview
if utils.is_available "goto-preview" then
  map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
  map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
  map("n", "gq", "<cmd>lua require('goto-preview').close_all_win()<CR>")
  map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
end


-- ForceWrite
map("n", "<C-s>", "<cmd>w!<CR>")

-- ForceQuit
map("n", "<C-q>", "<cmd>q!<CR>")

-- Terminal
if utils.is_available "nvim-toggleterm.lua" then
  map("n", "<C-\\>", "<cmd>ToggleTerm<CR>")
end

-- Comment
if utils.is_available "Comment.nvim" then
  -- Linewise toggle current line using C-/
  map('n', '<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')
  -- Linewise toggle using C-/
  map('x', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
end

-- TODO move which-key keymaps here

return M
