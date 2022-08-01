local M = {}

function M.config()
  local saga = safe_require('lspsaga')
  if not saga then
    return
  end

  saga.init_lsp_saga({})
end

return M
