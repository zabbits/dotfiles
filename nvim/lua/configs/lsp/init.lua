local lsp_installer = _G.safe_require("nvim-lsp-installer")
local lspconfig = _G.safe_require('lspconfig')
if not lsp_installer or not lspconfig then
  return
end

local handlers = _G.safe_require('configs.lsp.handlers')
if not handlers then
  return
end
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
  local defaultOpts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }
  require("configs.lsp.vue-volar")
  lspconfig.volar_api.setup(defaultOpts)
  lspconfig.volar_doc.setup(defaultOpts)
  lspconfig.volar_html.setup(defaultOpts)
end
