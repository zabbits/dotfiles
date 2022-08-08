local mason_lsp = safe_require("mason-lspconfig")
local lspconfig = safe_require('lspconfig')
if not mason_lsp or not lspconfig then
  return
end

local handlers = safe_require('configs.lsp.handlers')
if not handlers then
  return
end
handlers.setup()

for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  local present, av_overrides = pcall(require, "configs.lsp.server-settings." .. server_name)
  if present then
    opts = vim.tbl_deep_extend("force", av_overrides, opts)
  end

  if server_name == "sumneko_lua" then
    local luadev = safe_require("lua-dev")
    if luadev then
      opts = luadev.setup({
        lspconfig = {
          on_attach = handlers.on_attach,
          capabilities = handlers.capabilities,
        },
      })
    end
  end
  -- using rust tools for rust
  if server_name ~= "rust_analyzer" then
    lspconfig[server_name].setup(opts)
  end
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
