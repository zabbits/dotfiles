local M = {}

function M.config()
  local fold = _G.safe_require('pretty-fold')
  if not fold then
    return
  end
  fold.setup()
  -- fold.preview.setup()
end

return M
