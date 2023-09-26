local mason = {
	"williamboman/mason.nvim",
	opts = true,
}

local mason_lsp = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = true,
	config = function()
		require("mason-lspconfig").setup({})
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		})
	end,
}

return {
	mason,
	mason_lsp,
}
