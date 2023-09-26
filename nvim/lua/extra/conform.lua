return {
	"stevearc/conform.nvim",
    keys = "gq",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
		})

		vim.keymap.set("n", "gq", function()
			conform.format({ lsp_fallback = true })
		end, { noremap = true, silent = true, desc = "Format" })
	end,
}
