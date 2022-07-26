local M = {}

function M.config()
  local rt = safe_require("rust-tools")
  local handlers = safe_require('configs.lsp.handlers')
  if not rt then
    return
  end
  rt.setup({
    tools = {
      autoSetHints = false,
      hover_with_actions = true,
      -- options right now: termopen / quickfix
      executor = require("rust-tools/executors").termopen,
    },
    server = {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
    }
  })
end

return M
