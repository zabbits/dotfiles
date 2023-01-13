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
  require("luasnip.loaders.from_lua").lazy_load()

  -- fix luasnip use tab go to history
  vim.api.nvim_create_augroup("_luasnip", {})
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = "_luasnip",
    callback = function()
      local luasnip = safe_require('luasnip')
      if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
          and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
          and not luasnip.session.jump_active
      then
        luasnip.unlink_current()
      end
    end
  })
end

return M
