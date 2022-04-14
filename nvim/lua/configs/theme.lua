local M = {}

function M.config()
  local utils = require('core.utils')
  local scheme = 'default'

  local nebulous = utils.safe_require('nebulous')
  if nebulous then
    nebulous.setup()
  end

  local tokyonight = utils.safe_require('tokyonight')
  if tokyonight then
    scheme = 'tokyonight'
  end

  local tokyodark = utils.safe_require('tokyodark')
  if tokyodark then
    scheme = 'tokyodark'
  end

  vim.cmd("colorscheme "..scheme)

end
return M
