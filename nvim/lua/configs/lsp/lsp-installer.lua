local M = {}

function M.config()
  local lsp_installer = _G.safe_require("nvim-lsp-installer")
  if not lsp_installer then
    return
  end

  lsp_installer.setup({
    ui = {
      icons = {
        server_installed = "",
        server_pending = "",
        server_uninstalled = "",
      },
    },
  })
end

return M
