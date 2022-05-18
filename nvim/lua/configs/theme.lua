local M = {}

function M.config()
  local utils = require('core.utils')
  local scheme = 'default'

  local kanagawa = utils.safe_require('kanagawa')
  if kanagawa then
    scheme = 'kanagawa'
  end
  vim.cmd("colorscheme " .. scheme)
end

return M
