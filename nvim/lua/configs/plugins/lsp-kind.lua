local M = {
  'onsails/lspkind.nvim',
  event = { 'BufRead', 'BufNewFile' },
}

function M.config()
  local lspkind = _G.safe_require('lspkind')
  lspkind.init({})
end

return M
