local M = {}

function M.setup()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
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

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local cmd = vim.api.nvim_create_autocmd
    local augroup = vim.api.nvim_create_augroup
    local gs_id = augroup("_lsp_document_highlight", {})
    cmd({ "CursorHold", "CursorHoldI" }, {
      desc = "LSP Highlight Document",
      group = gs_id,
      buffer = bufnr,
      command = "lua vim.lsp.buf.document_highlight()",
    })
    cmd("CursorMoved", {
      desc = "LSP Clear Highlight Document",
      group = gs_id,
      buffer = bufnr,
      command = "lua vim.lsp.buf.clear_references()",
    })
  end
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver"
      or client.name == "jsonls"
      or client.name == "html"
      or client.name == "sumneko_lua" then
    client.server_capabilities.document_formatting = false
  end

  lsp_highlight_document(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

return M
