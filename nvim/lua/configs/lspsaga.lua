local M = {}

function M.config()
  local saga = safe_require('lspsaga')
  if not saga then
    return
  end

  saga.init_lsp_saga({
    scroll_in_preview = {
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
    },
  })
end

return M
