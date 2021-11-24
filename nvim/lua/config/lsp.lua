local M = {}

M.setup = function ()
  local lsp_installer = require("nvim-lsp-installer")
  -- Register a handler that will be called for all installed servers.
  -- Alternatively, you may also register handlers on specific server instances instead (see example below).
  -- lsp completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  local function notify(server)
    local msg = 'Actived Server: ' .. server.name
    vim.notify(msg, 'info', {title = 'LSP', timeout = 2000})
  end

  local function on_attach(server, burnr)
    notify(server)
  end

  lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach
    }
    server:setup(opts)
  end)
end

return M
