local M = {}

function M.config()
  local ufo = _G.safe_require("ufo")
  if not ufo then
    return
  end
  ufo.setup()
end

return M
