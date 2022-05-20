local M = {}

function M.config()
  local scheme = 'default'

  local kanagawa = _G.safe_require('kanagawa')
  if kanagawa then
    scheme = 'kanagawa'
  end
  vim.cmd("colorscheme " .. scheme)
end

return M
