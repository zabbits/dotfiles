local M = {}

function M.config()
  local utils = require('core.utils')
  local scheme = 'default'

  local onenord = utils.safe_require('onenord')
  if onenord then
    scheme = 'onenord'
  end

  local kanagawa = utils.safe_require('kanagawa')
  if kanagawa then
    scheme = 'kanagawa'
  end
  vim.cmd("colorscheme " .. scheme)
end

return M
