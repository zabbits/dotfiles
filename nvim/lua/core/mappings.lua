local M = {}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }


-- BASH-style movement in insert mode
vim.api.nvim_set_keymap("i", "<C-a>", "<C-o>^", opts)
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>$", opts)

-- ESC cancel higlight
map("n", "<ESC>", ":nohlsearch<CR>", opts)
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Insert mode movement
map("i", "<A-h>", "<esc>i", opts)
map("i", "<A-l>", "<esc>la", opts)


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
map('n', 'H', '<cmd>BufferLineCyclePrev<cr>')
map('n', 'L', '<cmd>BufferLineCycleNext<cr>')

-- === Lazy ===
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- === LSP ===
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "Installer Info" })

-- === LSP Trouble ===
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "TroubleToggle" })
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Trouble Workspace" })
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Trouble Document" })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Trouble loclist" })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Trouble quickfix" })
map("n", "gR", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble References" })
map("n", "gr", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble References" })

-- === LSP Preview ===
map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = "Preview Definition" })
map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
  { desc = "Preview Implementation" })
map("n", "gq", "<cmd>lua require('goto-preview').close_all_win()<CR>", { desc = "Preview Close" })
map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { desc = "Preview References" })

-- === Terminal ===
map("n", "<C-\\>", "<cmd>ToggleTerm<CR>")
map({ "n", "i", "v", "x" }, "<F5>", '<ESC><cmd>TermExec cmd="cc % -o temp.out;./temp.out;rm ./temp.out"<CR>',
  { desc = "Run C" })

-- === Comment ===
-- Linewise toggle current line using C-/
map('n', '<C-/>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')
-- Linewise toggle using C-/
map('x', '<C-/>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- === Neo-tree ===
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })
map("n", "<leader>oo", "<cmd>Neotree reveal toggle<CR>", { desc = "Toggle Reveal Explorer" })
map("n", "<leader>og", "<cmd>Neotree toggle git_status<CR>", { desc = "Toggle Git Status" })
map("n", "<leader>ob", "<cmd>Neotree toggle buffers<CR>", { desc = "Toggle Buffers" })
map("n", "<leader>of", "<cmd>NeoTreeFocus<CR>", { desc = "Focus" })

-- === Close Buffer ===
map("n", "<leader>c", "<cmd>Bdelete<CR>", { desc = "Close Buffer" })

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
map("n", "<leader><leader>", function()
  local cp = require("command-palette")
  local ft2label = {
    rust = "Rust",
    norg = "Neorg",
    go = "Go",
  }
  local ft = vim.bo.ft
  local label = ft2label[ft]
  if label then
    cp.palette:next(label):open()
  else
    cp.palette:open()
  end
end,
  { desc = "Commands Palette" })


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

-- === Harpon ===
map("n", "<leader>ha", function()
  require("harpoon.mark").add_file()
end,
  { desc = "Add file" })

map("n", "<leader>hd", function()
  require("harpoon.mark").rm_file()
end,
  { desc = "Remove file" })

map("n", "<leader>hc", function()
  require("harpoon.mark").clear_all()
end,
  { desc = "Clear file" })

map("n", "<leader>hl", function()
  require("harpoon.ui").toggle_quick_menu()
end,
  { desc = "List file" })

map("n", "<leader>hn", function()
  require("harpoon.ui").nav_next()
end,
  { desc = "Next file" })

map("n", "<leader>hb", function()
  require("harpoon.ui").nav_prev()
end,
  { desc = "Prev file" })

map("n", "<leader>hh", function()
  require("telescope._extensions").manager.harpoon.marks()
end,
  { desc = "Telescope file" })
-- TIPS: keymaps when use harpoon with telescope
-- "i", "<c-d>", delete_harpoon_mark
-- "n", "<c-d>", delete_harpoon_mark

-- === Projects ===
map("n", "<leader>fp", function()
  require("telescope._extensions").manager.projects.projects()
end,
  { desc = "Find projects" })

-- === Session ===
map("n", "<leader>fs", function()
  require('telescope').extensions.possession.list()
end,
  { desc = "Find Session" })

map("n", "<leader>ss", function()
  require('configs.plugins.session.posession-helper').save_session()
end, { desc = "Session Save" })
map("n", "<leader>sd", ":PossessionDelete <CR>", { desc = "Session Delete" })


-- === Fold ===
map('n', 'zR', function() require('ufo').openAllFolds() end)
map('n', 'zM', function() require('ufo').closeAllFolds() end)


-- === OS Yank ===
map('v', '<leader>y', function() require('osc52').copy_visual() end, { desc = "OSYank" })


-- === DAP ===
-- modified function keys found with `showkey -a` in the terminal to get key code
-- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
map('n', "<F5>", function() require("dap").continue() end, { desc = "Debugger: Start" })
map('n', "<F17>", function() require("dap").terminate() end, { desc = "Debugger: Stop" }) -- Shift+F5
map('n', "<F29>", function() require("dap").restart_frame() end, { desc = "Debugger: Restart" }) -- Control+F5
map('n', "<F6>", function() require("dap").pause() end, { desc = "Debugger: Pause" })
map('n', "<F9>", function() require("dap").toggle_breakpoint() end, { desc = "Debugger: Toggle Breakpoint" })
map('n', "<F10>", function() require("dap").step_over() end, { desc = "Debugger: Step Over" })
map('n', "<F11>", function() require("dap").step_into() end, { desc = "Debugger: Step Into" })
map('n', "<F23>", function() require("dap").step_out() end, { desc = "Debugger: Step Out" }) -- Shift+F11
map('n', "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint (F9)" })
map('n', "<leader>dB", function() require("dap").clear_breakpoints() end, { desc = "Clear Breakpoints" })
map('n', "<leader>dc", function() require("dap").continue() end, { desc = "Start/Continue (F5)" })
map('n', "<leader>di", function() require("dap").step_into() end, { desc = "Step Into (F11)" })
map('n', "<leader>do", function() require("dap").step_over() end, { desc = "Step Over (F10)" })
map('n', "<leader>dO", function() require("dap").step_out() end, { desc = "Step Out (S-F11)" })
map('n', "<leader>dq", function() require("dap").close() end, { desc = "Close Session" })
map('n', "<leader>dQ", function() require("dap").terminate() end, { desc = "Terminate Session (S-F5)" })
map('n', "<leader>dp", function() require("dap").pause() end, { desc = "Pause (F6)" })
map('n', "<leader>dr", function() require("dap").restart_frame() end, { desc = "Restart (C-F5)" })
map('n', "<leader>dR", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
map('n', "<leader>du", function() require("dapui").toggle({}) end, { desc = "Toggle Debugger UI" })
map('n', "<leader>dh", function() require("dap.ui.widgets").hover() end, { desc = "Debugger Hover" })


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
