local M = {
  "rafamadriz/friendly-snippets",
  enabled = true,
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
}

function M.config()
  local present, luasnip = pcall(require, "luasnip")
  if not present then
    return
  end

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_lua").lazy_load()
end

return M
