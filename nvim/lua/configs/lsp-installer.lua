local M = {}

function M.config()
  local utils = require("core.utils")
  local lsp_installer = utils.safe_require("nvim-lsp-installer")
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
