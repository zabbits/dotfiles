local M = {}

function M.config()
  local hop = safe_require('hop')
  if not hop then
    return
  end
  hop.setup({})
end

return M
