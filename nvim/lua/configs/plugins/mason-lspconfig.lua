local M = {
  "williamboman/mason-lspconfig.nvim",
  event = { 'BufRead', 'BufNewFile' },
  dependencies = { "mason.nvim" },
}

function M.config()
  local mason_lsp = safe_require('mason-lspconfig')
  if not mason_lsp then
    return
  end

  mason_lsp.setup()
end

return M
