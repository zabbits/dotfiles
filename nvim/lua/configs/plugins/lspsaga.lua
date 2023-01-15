local M = {
  "glepnir/lspsaga.nvim",
}

function M.config()
  local saga = require("lspsaga")
  saga.setup({
    ui = {
      code_action = '',
    },
    lightbulb = {
      enable = true,
      enable_in_insert = true,
      sign = false,
      sign_priority = 40,
      virtual_text = true,
    },
    symbol_in_winbar = {
      enable = true,
      separator = '  ',
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
      respect_root = false,
      color_mode = true,
    },
  })
end

return M
