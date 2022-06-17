local M = {}

function M.config()
  local rt = _G.safe_require("rust-tools")
  if not rt then
    return
  end
  rt.setup({
    hover_with_actions = true,
  })
end

return M
