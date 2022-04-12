local M = {}

function M.config()
  local n_ok, ne = pcall(require, 'nebulous')
  if n_ok then
    ne.setup()
  end
  vim.cmd("colorscheme duskfox")
end
return M
