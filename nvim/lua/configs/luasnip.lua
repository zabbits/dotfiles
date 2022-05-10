local M = {}

function M.config()
  local present, luasnip = pcall(require, "luasnip")
  if not present then
    return
  end

  luasnip.setup({
    history = false,
  })
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
