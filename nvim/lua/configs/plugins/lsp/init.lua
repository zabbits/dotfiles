local M = {
  "neovim/nvim-lspconfig",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    "mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "incline.nvim",
    "lspkind.nvim",
    "goto-preview",
    "lsp_signature.nvim",
    "trouble.nvim",
    "lspsaga.nvim",
    "lsp_lines.nvim",
    "fidget.nvim",
  },
}

function M.config()
  local luadev = safe_require("neodev")
  if luadev then
    luadev.setup({})
  end

  local mason_lsp = safe_require("mason-lspconfig")
  local lspconfig = safe_require('lspconfig')
  if not mason_lsp or not lspconfig then
    return
  end

  local handlers = safe_require('configs.plugins.lsp.handlers')
  if not handlers then
    return
  end
  handlers.setup()

  for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
    local opts = {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
    }

    local present, av_overrides = pcall(require, "configs.plugins.lsp.server-settings." .. server_name)
    if present then
      opts = vim.tbl_deep_extend("force", av_overrides, opts)
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
    require("configs.plugins.lsp.vue-volar")
    lspconfig.volar_api.setup(defaultOpts)
    lspconfig.volar_doc.setup(defaultOpts)
    lspconfig.volar_html.setup(defaultOpts)
  end
end

return M
