local M = {}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }


-- BASH-style movement in insert mode
vim.api.nvim_set_keymap("i", "<C-a>", "<C-o>^", opts)
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>$", opts)

-- ESC cancel higlight
map("n", "<ESC>", ":nohlsearch<CR>", opts)
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Insert mode movement
map("i", "<A-h>", "<esc>i", opts)
map("i", "<A-l>", "<esc>la", opts)
map("i", "<D-h>", "<esc>i", opts)
map("i", "<D-l>", "<esc>la", opts)


-- disable Ex mode:
map("n", "Q", "<Nop>")
-- ForceQuit
map("n", "<C-q>", "<cmd>q!<CR>")
-- insert current time
map("n", "<A-i>", ":put =strftime('%Y-%m-%d %H:%M:%S')<CR>", opts)

-- === Window navigation ===
map('n', '<C-h>', '<C-w>h', opts);
map('n', '<C-l>', '<C-w>l', opts);
map('n', '<C-k>', '<C-w>k', opts);
map('n', '<C-j>', '<C-w>j', opts);


-- === Navigate buffers ===
-- map('n', 'H', '<cmd>BufferLineCyclePrev<cr>')
-- map('n', 'L', '<cmd>BufferLineCycleNext<cr>')
map('n', 'H', '<cmd>bp<cr>')
map('n', 'L', '<cmd>bn<cr>')

-- === Close Buffer ===
map("n", "<leader>c", "<cmd>Bdelete<CR>", { desc = "Close Buffer" })

-- === Lazy ===
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- === LSP ===
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "Installer Info" })

-- === LSP Trouble ===
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "TroubleToggle" })
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Trouble Workspace" })
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Trouble Document" })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Trouble loclist" })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Trouble quickfix" })


-- === Terminal ===
map("n", "<C-\\>", "<cmd>ToggleTerm<CR>")
map({ "n", "i", "v", "x" }, "<F5>", '<ESC><cmd>TermExec cmd="cc % -o temp.out;./temp.out;rm ./temp.out"<CR>',
  { desc = "Run C" })

-- map('n', comment_key, function() require("Comment.api").toggle.linewise.current() end)
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })
map("n", "<leader>oo", "<cmd>Neotree reveal toggle<CR>", { desc = "Toggle Reveal Explorer" })
map("n", "<leader>og", "<cmd>Neotree toggle git_status<CR>", { desc = "Toggle Git Status" })
map("n", "<leader>ob", "<cmd>Neotree toggle buffers<CR>", { desc = "Toggle Buffers" })
map("n", "<leader>of", "<cmd>NeoTreeFocus<CR>", { desc = "Focus" })

-- === GitSigns ===
local function gitsigns()
  return require("gitsigns")
end

map("n", "<leader>gj", function()
  gitsigns().next_hunk()
end,
  { desc = "Next Hunk" })

map("n", "<leader>gk",
  function()
    gitsigns().prev_hunk()
  end, { desc = "Prev Hunk" })

map("n", "<leader>gl",
  function()
    gitsigns().blame_line()
  end, { desc = "Blame" })

map("n", "<leader>gp", function()
  gitsigns().preview_hunk()
end
  , { desc = "Preview Hunk" })

map("n", "<leader>gc", function()
  gitsigns().reset_hunk()
end, { desc = "Reset Hunk" })

map("n", "<leader>gr", function()
  gitsigns().reset_buffer()
end, { desc = "Reset Buffer" })

map("n", "<leader>gh", function()
  gitsigns().stage_hunk()
end, { desc = "Stage Hunk" })

map("n", "<leader>gu", function()
  gitsigns().undo_stage_hunk()
end, { desc = "Undo Stage Hunk" })

map("n", "<leader>gd", function()
  gitsigns().diffthis()
end, { desc = "Diff" })


-- === Telescope ===
map("n", "<leader><space>", function()
  require("telescope.builtin").find_files()
end,
  { desc = "Files" })

map("n", "<leader>/", function()
  require("telescope.builtin").live_grep()
end,
  { desc = "Words" })

map("n", "<leader>sb", function()
  require("telescope.builtin").git_branches()
end,
  { desc = "Checkout branch" })

map("n", "<leader>sh", function()
  require("telescope.builtin").help_tags()
end,
  { desc = "Find Help" })

map("n", "<leader>sm", function()
  require("telescope.builtin").man_pages()
end,
  { desc = "Man Pages" })

map("n", "<leader>sn", "<cmd>Telescope notify<cr>", { desc = "Notifications" })

map("n", "<leader>sr", function()
  require("telescope.builtin").registers()
end,
  { desc = "Registers" })

map("n", "<leader>sk", function()
  require("telescope.builtin").keymaps()
end,
  { desc = "Keymaps" })

map("n", "<leader>sc", function()
  require("telescope.builtin").commands()
end,
  { desc = "Commands" })

map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end,
  { desc = "Find Buffers" })

map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end,
  { desc = "Find Files" })

map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end,
  { desc = "Find Help" })

map("n", "<leader>fm", function()
  require("telescope.builtin").marks()
end,
  { desc = "Find Marks" })

map("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end,
  { desc = "Find Old Files" })

map("n", "<leader>fw", function()
  require("telescope.builtin").live_grep()
end,
  { desc = "Find Words" })

map("n", "<leader>fc", function()
  require("telescope.builtin").find_files({ cwd = "$HOME/.config/nvim/" })
end,
  { desc = "Find Configurations" })

map("n", "<leader>fu", function()
  require("telescope").extensions.undo.undo()
end,
  { desc = "Find Undo" })

map("n", "<leader>ls", function()
  require("telescope.builtin").lsp_document_symbols()
end,
  { desc = "Document Symbols" })

-- === Neorg ===
map("n", "<leader>nv", function()
  vim.cmd("Neorg gtd views")
end, { desc = "Gtd views" })
map("n", "<leader>ne", "<cmd>Neorg gtd edit<cr>", { desc = "Gtd edit" })
map("n", "<leader>nc", "<cmd>Neorg gtd capture<cr>", { desc = "Gtd capture" })

-- === Session ===
map("n", "<leader>fs", function()
  require('telescope').extensions.possession.list()
end,
  { desc = "Find Session" })

map("n", "<leader>ss", function()
  require('plugins.session.posession-helper').save_session()
end, { desc = "Session Save" })
map("n", "<leader>sd", ":PossessionDelete <CR>", { desc = "Session Delete" })

-- === OSC Yank ===
map('x', '<leader>y', function() require('osc52').copy_visual() end, { desc = "OSYank" })

-- === comment ===
-- Linewise toggle current line using C-/
local comment_key = '<C-_>'
local os = vim.loop.os_uname().sysname:lower()
if os == 'darwin' then
  comment_key = '<C-/>'
end
map('i', comment_key, function() require("Comment.api").toggle.linewise.current() end)
map('n', comment_key, function() require("Comment.api").toggle.linewise.current() end)
map('x', comment_key, function() require("Comment.api").toggle.linewise(vim.fn.visualmode()) end)

return M
