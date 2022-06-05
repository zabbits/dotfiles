local M = {}

local utils = require "core.utils"
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("", "<Space>", "<Nop>", opts)
--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- BASH-style movement in insert mode
vim.api.nvim_set_keymap("i", "<C-a>", "<C-o>^", opts)
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>$", opts)

-- ESC cancel higlight
map("n", "<ESC>", ":nohlsearch<CR>", opts)
map("x", "J", "<cmd>move '>+1<CR>gv-gv")
map("x", "K", "<cmd>move '<-2<CR>gv-gv")
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- disable Ex mode:
map("n", "Q", "<Nop>")
-- ForceWrite
map("n", "<C-s>", "<cmd>w!<CR>")
-- ForceQuit
map("n", "<C-q>", "<cmd>q!<CR>")
-- insert current time
map("n", "<A-i>", ":put =strftime('%Y-%m-%d %H:%M:%S')<CR>", opts)

-- === Window navigation ===
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

-- === Navigate buffers ===
if utils.is_available "bufferline.nvim" then
  map("n", "]]", "<cmd>BufferLineCycleNext<cr>")
  map("n", "[[", "<cmd>BufferLineCyclePrev<cr>")
else
  map("n", "]]", "<cmd>bnext<CR>")
  -- Normal Leader Mappings --
  map("n", "[[", "<cmd>bprevious<CR>")
end

-- === LSP ===
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Diagnostic" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "Installer Info" })
map("n", "<leader>lr", "<cmd>IncRename<cr>", { desc = "Rename" })

-- code action menu
map("n", "<leader>xa", "<cmd>CodeActionMenu<CR>")

-- === LSP Symbols ===
if utils.is_available "symbols-outline.nvim" then
  map("n", "gs", "<cmd>SymbolsOutline<CR>")
end

-- === LSP Trouble ===
if utils.is_available "trouble.nvim" then
  map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "TroubleToggle" })
  map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Trouble Workspace" })
  map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Trouble Document" })
  map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Trouble loclist" })
  map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Trouble quickfix" })
  map("n", "gR", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble References" })
  map("n", "gr", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble References" })
end

-- === LSP Preview ===
if utils.is_available "goto-preview" then
  map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = "Preview Definition" })
  map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { desc = "Preview Implementation" })
  map("n", "gq", "<cmd>lua require('goto-preview').close_all_win()<CR>", { desc = "Preview Close" })
  map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { desc = "Preview References" })
end

-- === Terminal ===
if utils.is_available "nvim-toggleterm.lua" then
  map("n", "<C-\\>", "<cmd>ToggleTerm<CR>")
  map({"n", "i", "v", "x"}, "<F5>", '<ESC><cmd>TermExec cmd="cc % -o temp.out;./temp.out;rm ./temp.out"<CR>', { desc = "Run C" })
end

-- === Comment ===
if utils.is_available "Comment.nvim" then
  -- Linewise toggle current line using C-/
  map('n', '<C-/>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')
  -- Linewise toggle using C-/
  map('x', '<C-/>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
end

-- === Packer ===
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Compile" })
map("n", "<leader>pd", "<cmd>PackerClean<cr>", { desc = "Clean" })
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Install" })
map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Sync" })
map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Status" })
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Update" })

-- === Neo-tree ===
if utils.is_available "neo-tree.nvim" then
  map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })
  map("n", "<leader>oo", "<cmd>Neotree reveal toggle<CR>", { desc = "Toggle Reveal Explorer" })
  map("n", "<leader>og", "<cmd>Neotree toggle git_status<CR>", { desc = "Toggle Git Status" })
  map("n", "<leader>ob", "<cmd>Neotree toggle buffers<CR>", { desc = "Toggle Buffers" })
end

-- === Dashboard ===
if utils.is_available "dashboard-nvim" then
  map("n", "<leader>fn", "<cmd>DashboardNewFile<CR>", { desc = "New File" })
end

-- === Close Buffer ===
if utils.is_available "bufdelete.nvim" then
  map("n", "<leader>c", "<cmd>Bdelete<CR>", { desc = "Close Buffer" })
end

-- === GitSigns ===
if utils.is_available "gitsigns.nvim" then
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
    gitsigns.reset_buffer()
  end, { desc = "Reset Buffer" })

  map("n", "<leader>gh", function()
    gitsigns.stage_hunk()
  end, { desc = "Stage Hunk" })

  map("n", "<leader>gu", function()
    gitsigns.undo_stage_hunk()
  end, { desc = "Undo Stage Hunk" })

  map("n", "<leader>gd", function()
    gitsigns.diffthis()
  end, { desc = "Diff" })
end

-- === ToggleTerm ===
if utils.is_available "nvim-toggleterm.lua" then
end

-- === UrlView ===
if utils.is_available "urlview.nvim" then
  map("n", "<leader>sp", "<cmd>UrlView packer<cr>", { desc = "Search Plugin" })
end

-- === Telescope ===
if utils.is_available "telescope.nvim" then
  map("n", "<leader><leader>", function()
    require("telescope.builtin").commands()
  end,
    { desc = "Commands" })


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

  map("n", "<leader>ls", function()
    require("telescope.builtin").lsp_document_symbols()
  end,
    { desc = "Document Symbols" })
end

-- === Neorg ===
if utils.is_available('neorg') then
  map("n", "<leader>nv", "<cmd>Neorg gtd views<cr>", { desc = "Gtd views" })
  map("n", "<leader>ne", "<cmd>Neorg gtd edit<cr>", { desc = "Gtd edit" })
  map("n", "<leader>nc", "<cmd>Neorg gtd capture<cr>", { desc = "Gtd capture" })
end

-- === Harpon ===
if utils.is_available('harpoon') then
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
end

-- === Projects ===
if utils.is_available("project.nvim") then
  map("n", "<leader>fp", function()
    require("telescope._extensions").manager.projects.projects()
  end,
    { desc = "Find projects" })
end

-- === Session ===
if utils.is_available("possession.nvim") then
  map("n", "<leader>fs", function()
    require('telescope').extensions.possession.list()
  end,
    { desc = "Find Session" })

  -- map("n", "<leader>ss", ":PossessionSave <CR>", { desc = "Session Save" })
  map("n", "<leader>ss", function()
    require('configs.posession-helper').save_session()
  end, { desc = "Session Save" })
  map("n", "<leader>sd", ":PossessionDelete <CR>", { desc = "Session Delete" })

end

return M
