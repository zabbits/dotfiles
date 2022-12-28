local M = {
  "L3MON4D3/LuaSnip",
  lazy = true,
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
}

function M.config()
  local present, luasnip = pcall(require, "luasnip")
  if not present then
    return
  end

  require("luasnip.loaders.from_lua").lazy_load()
end

return M
