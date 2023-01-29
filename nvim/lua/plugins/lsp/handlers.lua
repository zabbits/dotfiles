local M = {}
function M.setup()
  local status = require("core.status")
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
  bmap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "Goto implementation" })
  bmap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Goto type definition" })
  -- bmap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Hover diagnostic" })
  bmap(bufnr, 'n', 'gl', '<cmd>lua require("lsp_lines").toggle()<CR>', { desc = "Hover diagnostic" })
  -- bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "Hover document" })
  bmap(bufnr, 'n', '<C-t>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature help" })
  bmap(bufnr, 'i', '<C-t>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature help" })
  bmap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "Rename" })
  bmap(bufnr, 'n', '<leader>lc', '<cmd>lua vim.lsp.buf.clear_references()<CR>', { desc = "Clear" })
  -- lspsaga stuff
  if client.name == 'rust_analyzer' then
    bmap(bufnr, "n", "K", "<cmd>RustHoverActions<CR>", { silent = true })
  else
    bmap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
  end
  bmap(bufnr, "n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true, noremap = true })
  bmap(bufnr, "i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true, noremap = true })
  bmap(bufnr, "n", "<leader>la", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
  bmap(bufnr, "v", "<leader>la", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
  bmap(bufnr, "n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
  bmap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
  bmap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver"
      or client.name == "jsonls"
      or client.name == "html" then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_highlight_document(client, bufnr)
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
  lineFoldingOnly = true
}

return M
