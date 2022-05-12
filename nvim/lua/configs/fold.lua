local M = {}

function M.config()
  local utils = require('core.utils')
  local fold = utils.safe_require('pretty-fold')
  if not fold then
    return
  end
  fold.setup()
  -- fold.preview.setup()
end

return M
