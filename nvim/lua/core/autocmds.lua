-- see h: api-autocmd
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ====================
--   General Settings
-- ====================
-- Check if we need to reload the file when it changed
cmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
cmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- close some filetypes with <q>
cmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
		"notify",
		"sagahover",
		"sagarename",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

cmd("FileType", {
	command = "set formatoptions-=cro",
})

local as_id = augroup("alpha_settings", {})
cmd("User", {
	desc = "",
	group = as_id,
	pattern = "AlphaReady",
	callback = function()
		vim.opt.showtabline = 0
		vim.opt.laststatus = 0
	end,
})
cmd("BufEnter", {
	desc = "Disable tabline and statusline in alpha",
	group = as_id,
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "alpha" then
			vim.opt.showtabline = 0
			vim.opt.laststatus = 0
			cmd("BufUnload", {
				desc = "Reset",
				group = "alpha_settings",
				pattern = "<buffer>",
				callback = function()
					vim.opt.showtabline = 2
					vim.opt.laststatus = 3
				end,
			})
		end
		if vim.bo.filetype == "norg" then
			vim.opt.showtabline = 2
			vim.opt.laststatus = 3
		end
	end,
})

-- fix telescope cannot use <C-R>, which-key hiject it.
augroup("_telescope", {})
cmd("FileType", {
	group = "_telescope",
	pattern = "TelescopePrompt",
	command = "inoremap <buffer> <silent> <C-r> <C-r>",
})

-- relative number
local exclude_filetype = {
	"NvimTree",
	"neo-tree",
	"neo-tree-popup",
	"dashboard",
	"Outline",
	"Trouble",
	"notify",
	"mason",
}
local function disable_number()
	local ft = vim.bo.filetype
	if vim.tbl_contains(exclude_filetype, ft) then
		vim.opt.number = false
		vim.opt.relativenumber = false
		return true
	end
	return false
end

augroup("_relative_number", {})
cmd({ "InsertEnter" }, {
	desc = "Disable Relative Number",
	group = "_relative_number",
	callback = function()
		if not disable_number() then
			vim.opt.number = true
			vim.opt.relativenumber = false
		end
	end,
})
cmd({ "InsertLeave" }, {
	desc = "Enable Relative Number",
	group = "_relative_number",
	callback = function()
		if not disable_number() then
			vim.opt.number = true
			vim.opt.relativenumber = true
		end
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
