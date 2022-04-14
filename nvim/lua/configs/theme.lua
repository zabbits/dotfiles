local M = {}

function M.config()
  local n_ok, ne = pcall(require, 'nebulous')
  if n_ok then
    ne.setup()
  end
  
  local t_ok, to = pcall(require, 'tokyonight')
  if to then
    vim.cmd("colorscheme tokyonight")
  else
    vim.cmd("colorscheme duskfox")
  end

end
return M
