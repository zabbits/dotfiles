local function nui_popup(title, filetype, lines)
	local Popup = require("nui.popup")
	local event = require("nui.utils.autocmd").event

	local popup = Popup({
		position = {
			row = "50%",
			col = "50%",
		},
		size = {
			width = 40,
			height = 10,
		},
		enter = true,
		focusable = true,
		zindex = 50,
		relative = "win",
		border = {
			padding = {
				top = 2,
				bottom = 2,
				left = 3,
				right = 3,
			},
			style = "rounded",
			text = {
				top = title,
				top_align = "center",
			},
		},
	})

	popup:mount()

	popup:on(event.BufLeave, function()
		popup:unmount()
	end)

	popup:map("n", "q", function()
		popup:unmount()
	end, { noremap = true })

	for i, line in pairs(lines) do
		local bufnr, ns_id, linenr_start = popup.bufnr, -1, i
		line:render(bufnr, ns_id, linenr_start)
	end

	vim.api.nvim_buf_set_option(popup.bufnr, "filetype", filetype)
	vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", false)
	vim.api.nvim_buf_set_option(popup.bufnr, "readonly", true)
end

local util = {}

util.icons = {
	powerline = {
		-- 
		vertical_bar_thin = "│",
		vertical_bar = "┃",
		block = "█",
		----------------------------------------------
		left = "",
		left_filled = "",
		right = "",
		right_filled = "",
		----------------------------------------------
		slant_left = "",
		slant_left_thin = "",
		slant_right = "",
		slant_right_thin = "",
		----------------------------------------------
		slant_left_2 = "",
		slant_left_2_thin = "",
		slant_right_2 = "",
		slant_right_2_thin = "",
		----------------------------------------------
		left_rounded = "",
		left_rounded_thin = "",
		right_rounded = "",
		right_rounded_thin = "",
		----------------------------------------------
		trapezoid_left = "",
		trapezoid_right = "",
		----------------------------------------------
		line_number = "",
		column_number = "",
	},
	padlock = "",
	circle_small = "●", -- ●
	circle = "", -- 
	circle_plus = "", -- 
	dot_circle_o = "", -- 
	circle_o = "⭘", -- ⭘
}

util.mode = setmetatable({
	n = "normal",
	no = "op",
	nov = "op",
	noV = "op",
	["no"] = "op",
	niI = "normal",
	niR = "normal",
	niV = "normal",
	nt = "normal",
	v = "visual",
	V = "visual_lines",
	[""] = "visual_block",
	s = "select",
	S = "select",
	[""] = "block",
	i = "insert",
	ic = "insert",
	ix = "insert",
	R = "replace",
	Rc = "replace",
	Rv = "v_replace",
	Rx = "replace",
	c = "command",
	cv = "command",
	ce = "command",
	r = "enter",
	rm = "more",
	["r?"] = "confirm",
	["!"] = "shell",
	t = "terminal",
	["null"] = "none",
}, {
	__call = function(self, raw_mode)
		return self[raw_mode]
	end,
})

util.mode_lable = {
	normal = "NORMAL",
	op = "OP",
	visual = "VISUAL",
	visual_lines = "V-LINES",
	visual_block = "V-BLOCK",
	select = "SELECT",
	block = "BLOCK",
	insert = "INSERT",
	replace = "REPLACE",
	v_replace = "V-REPLACE",
	command = "COMMAND",
	enter = "ENTER",
	more = "MORE",
	confirm = "CONFIRM",
	shell = "SHELL",
	terminal = "TERMINAL",
	none = "NONE",
}

util.ts = {
	buf_module_info = function()
		local configs = require("nvim-treesitter.configs")
		local parsers = require("nvim-treesitter.parsers")
		local modules = configs.available_modules()
		local lang = parsers.get_buf_lang()
		local NuiLine = require("nui.line")

		local count = #modules
		local result = ""
		local lines = {}
		for i, module in ipairs(modules) do
			local line = NuiLine()
			if configs.is_enabled(module, lang, 0) then
				line:append("" .. " ")
			else
				line:append("" .. " ", "Error")
			end
			line:append(module)

			table.insert(lines, line)
		end
		nui_popup("TSModuleInfo", "TSModuleInfo", lines)
	end,
}

local special_bufs = require('core.configs').heirline.special_buf_name
util.is_special_buf = function(buf_type)
	return vim.tbl_contains(special_bufs, buf_type)
end

return util
