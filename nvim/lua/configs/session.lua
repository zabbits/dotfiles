local M = {}

function M.config()
  local utils      = require('core.utils')
  local possession = utils.safe_require('possession')
  if not possession then
    return
  end
  possession.setup({})
end

return M
