local M = {}
function M.setup()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
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
    local gid = vim.api.nvim_create_augroup("_lsp_highlight_document", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      desc = "Highlight document on cursor hold",
      group = gid,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "Clear references on cursor hold",
      group = gid,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

local function buffer_key_maps(client, bufnr)
  local bmap = vim.api.nvim_buf_set_keymap
  bmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "Goto declaration" })
  bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Goto definition" })
  bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "Goto implementation" })
  bmap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Goto type definition" })
  bmap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Hover diagnostic" })
  bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "Hover document" })
  bmap(bufnr, 'n', '<C-t>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature help" })
  bmap(bufnr, 'i', '<C-t>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature help" })
  bmap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "Rename" })
  bmap(bufnr, 'n', '<leader>lc', '<cmd>lua vim.lsp.buf.clear_references()<CR>', { desc = "Clear" })
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver"
      or client.name == "jsonls"
      or client.name == "html" then
    client.server_capabilities.documentFormattingProvider = false
  end

  local aerial = _G.safe_require('aerial')
  if aerial then
    aerial.on_attach(client, bufnr)
  end
  lsp_highlight_document(client, bufnr)
  buffer_key_maps(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = _G.safe_require("cmp_nvim_lsp")
if cmp_nvim_lsp then
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

return M
