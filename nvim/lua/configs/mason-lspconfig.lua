local M = {}

function M.config()
  local mason_lsp = safe_require('mason-lspconfig')
  if not mason_lsp then
    return
  end

  mason_lsp.setup()
end

return M
