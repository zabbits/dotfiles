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
	bmap(bufnr, "n", "gi", "<cmd>Trouble lsp_implementations<CR>", { desc = "Goto implementation" })
	bmap(bufnr, "n", "gt", "<cmd>Trouble lsp_type_definitions<CR>", { desc = "Goto implementation" })
	-- bmap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Goto type definition" })
	bmap(bufnr, "n", "gl", '<cmd>lua require("lsp_lines").toggle()<CR>', { desc = "Hover diagnostic" })
	bmap(bufnr, "n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
  -- TODO: Signature help
	bmap(bufnr, "i", "<C-y>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
	bmap(bufnr, "n", "<leader>lc", "<cmd>lua vim.lsp.buf.clear_references()<CR>", { desc = "Clear" })
	vim.keymap.set("n", "<leader>lf", format, { desc = "LSP Format", buffer = true })
	vim.keymap.set("n", "gq", format, { desc = "LSP Format", buffer = true })
	-- lspsaga stuff
	if client.name == "rust_analyzer" then
		bmap(bufnr, "n", "K", "<cmd>RustHoverActions<CR>", { silent = true })
	else
		bmap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
	end
	bmap(bufnr, "n", "gd", "<cmd>Trouble lsp_definitions<CR>", { desc = "Goto definition" })
	bmap(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
	bmap(bufnr, "v", "ga", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "<C-CR>", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
	bmap(bufnr, "v", "<C-CR>", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "gR", "<cmd>Lspsaga peek_definition<CR>", { silent = true, noremap = true })
	-- bmap(bufnr, "n", "go", "<cmd>Lspsaga outline<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "<leader>lo", "<cmd>vim.lsp.buf.inlay_hint(bufnr, true)<CR>", { silent = true, noremap = true })
	bmap(bufnr, "n", "<leader>lh", "<cmd>vim.lsp.buf.inlay_hint(bufnr, false)<CR>", { silent = true, noremap = true })
  
end

M.on_attach = function(client, bufnr)
  buffer_key_maps(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local if_nil = function(val, default)
  if val == nil then return default end
  return val
end

local default_capabilities = function(override)
  override = override or {}

  return {
    textDocument = {
      completion = {
        dynamicRegistration = if_nil(override.dynamicRegistration, false),
        completionItem = {
          documentationFormat = { "markdown", "plaintext" },
          snippetSupport = if_nil(override.snippetSupport, true),
          commitCharactersSupport = if_nil(override.commitCharactersSupport, true),
          deprecatedSupport = if_nil(override.deprecatedSupport, true),
          preselectSupport = if_nil(override.preselectSupport, true),
          tagSupport = if_nil(override.tagSupport, {
            valueSet = {
              1, -- Deprecated
            }
          }),
          insertReplaceSupport = if_nil(override.insertReplaceSupport, true),
          resolveSupport = if_nil(override.resolveSupport, {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
            },
          }),
          insertTextModeSupport = if_nil(override.insertTextModeSupport, {
            valueSet = {
              1, -- async_in_progress
              2, -- adjustIndentation
            }
          }),
          labelDetailsSupport = if_nil(override.labelDetailsSupport, true),
        },
        contextSupport = if_nil(override.snippetSupport, true),
        insertTextMode = if_nil(override.insertTextMode, 1),
        completionList = if_nil(override.completionList, {
          itemDefaults = {
            'commitCharacters',
            'editRange',
            'insertTextFormat',
            'insertTextMode',
            'data',
          }
        })
      },
    },
  }
end

M.capabilities = default_capabilities(M.capabilities)

-- for fold
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

return M
