local M = {}
function M.setup()
	local icons = require("core.icons")
	local signs = {
		{ name = "DiagnosticSignError", text = icons.lsp.error },
		{ name = "DiagnosticSignWarn", text = icons.lsp.warn },
		{ name = "DiagnosticSignHint", text = icons.lsp.hint },
		{ name = "DiagnosticSignInfo", text = icons.lsp.info },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = false,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)
end

local function format()
	local buf = vim.api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype
	local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

	vim.lsp.buf.format({
		bufnr = buf,
		filter = function(client)
			if have_nls then
				return client.name == "null-ls"
			end
			return client.name ~= "null-ls"
		end,
	})
end

local function buffer_key_maps(client, bufnr)
	local bmap = vim.api.nvim_buf_set_keymap
	bmap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto declaration" })
	bmap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Goto implementation" })
	bmap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Goto type definition" })
	bmap(bufnr, "n", "gl", '<cmd>lua require("lsp_lines").toggle()<CR>', { desc = "Hover diagnostic" })
	bmap(bufnr, "n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
	bmap(bufnr, "i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
	bmap(bufnr, "n", "<leader>lc", "<cmd>lua vim.lsp.buf.clear_references()<CR>", { desc = "Clear" })
	vim.keymap.set("n", "<leader>lf", format, { desc = "LSP Format", buffer = true })
	vim.keymap.set("n", "gq", format, { desc = "LSP Format", buffer = true })
	-- lspsaga stuff
	if client.name == "rust_analyzer" then
		bmap(bufnr, "n", "K", "<cmd>RustHoverActions<CR>", { silent = true })
	else
		bmap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
	end
	bmap(bufnr, "n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto definition" })
	bmap(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
	bmap(bufnr, "v", "ga", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "gR", "<cmd>Lspsaga peek_definition<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "go", "<cmd>Lspsaga outline<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
end

M.on_attach = function(client, bufnr)
	buffer_key_maps(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
	M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
end

-- for fold
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

return M
