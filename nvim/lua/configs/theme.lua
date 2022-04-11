local M = {}

function M.config()
  local kanagawa_status, kanagawa = pcall(require, 'kanagawa')
  if kanagawa_status then
    kanagawa.setup({})
  end

  vim.cmd [[
    try
      colorscheme kanagawa
    catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
      set background=dark
    endtry
  ]]
end

return M
