local utils = require("core.utils")
local lsp_installer = utils.safe_require("nvim-lsp-installer")
local lspconfig = utils.safe_require('lspconfig')
if not (lsp_installer and lspconfig) then
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

local handlers = utils.safe_require('configs.lsp.handlers')
handlers.setup()

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  local present, av_overrides = pcall(require, "configs.lsp.server-settings." .. server.name)
  if present then
    opts = vim.tbl_deep_extend("force", av_overrides, opts)
  end

  lspconfig[server.name].setup(opts)
end


-- 是否使用volar
local configs = require("core.configs")
if configs.lsp.volar then
  require("configs.lsp.vue-volar")
end
