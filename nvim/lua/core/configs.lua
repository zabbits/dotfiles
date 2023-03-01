local icons = require("core.icons")

local M = {
	lsp = {
		volar = false,
	},
	nonicons = false,
	noice = true,
	posession = {
		auto_save_name = "tmp_",
	},
	heirline = {
		special_buf = {
			["qf"] = "",
			["help"] = "",
			["man"] = "",
			["notify"] = "",
			["lspinfo"] = icons.lsp.base,
			["spectre_panel"] = "",
			["startuptime"] = "",
			["tsplayground"] = "",
			["PlenaryTestPopup"] = "",
			["sagahover"] = icons.lsp.base,
			["sagarename"] = icons.lsp.base,
			["lspsagaoutline"] = icons.lsp.base,
			["sagacodeaction"] = icons.lsp.base,
			["neo-tree"] = icons.file.directory,
			["neo-tree-popup"] = icons.file.directory,
			["TelescopePrompt"] = icons.telescope.base,
			["mason"] = icons.tools.base,
			["lazy"] = icons.lazy.base,
			["Trouble"] = icons.lsp.base,
			["TSModuleInfo"] = icons.treesitter.base,
		},
	},
}

return M
