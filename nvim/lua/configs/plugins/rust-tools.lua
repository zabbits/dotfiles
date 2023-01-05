local M = {
  'simrat39/rust-tools.nvim',
  ft = 'rust',
  dependencies = {
    'nvim-lspconfig',
    'plenary.nvim',
  },
}

function M.config()
  local rt = safe_require("rust-tools")
  local handlers = safe_require('configs.plugins.lsp.handlers')
  if not rt or not handlers then
    return
  end

  local mason_path = vim.env.HOME .. '/.local/share/nvim/mason/packages'
  local codelldb_path = mason_path .. '/codelldb/extension/adapter/codelldb'

  local os = vim.loop.os_uname().sysname:lower()
  local postfix = '.so'
  if os == 'darwin' then
    postfix = 'dylib'
  end

  local liblldb_path = mason_path .. '/codelldb/extension/lldb/lib/liblldb' .. postfix

  rt.setup({
    hover_actions = {
      auto_focus = true,
    },
    server = {
      settings = {
        ["rust-analyzer"] = {
          inlayHints = { locationLinks = false },
        },
      },
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
    },
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
        codelldb_path, liblldb_path)
    },
  })
end

return M
