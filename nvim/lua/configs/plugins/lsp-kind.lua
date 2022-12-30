local M = {
  'onsails/lspkind.nvim',
}

function M.config()
  local lspkind = _G.safe_require('lspkind')
  lspkind.init({})
end

return M
