local M = {}

function M.config()
  local saga = safe_require('lspsaga')
  if not saga then
    return
  end

  saga.init_lsp_saga({
    code_action_icon = "",
    code_action_lightbulb = {
      enable = true,
      enable_in_insert = true,
      cache_code_action = true,
      sign = true,
      update_time = 150,
      sign_priority = 20,
      virtual_text = false,
    },
    scroll_in_preview = {
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
    },
  })
end

return M
