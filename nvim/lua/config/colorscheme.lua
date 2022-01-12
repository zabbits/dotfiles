local kanagawa_status, kanagawa = pcall(require, 'kanagawa')
if kanagawa_status then
  local colors = require("kanagawa.colors").setup()
  local overrides = {
    -- override existing hl-groups, the new keywords are merged with existing ones
    -- swap CursorLine and Visual hl-groups
    CursorLine = { bg = colors.bg_visual },
    Visual = { bg = colors.bg_light1 },
  }
  kanagawa.setup({ overrides = overrides })
end

local enfocado_ok, _ = pcall(require, 'enfocado')
if enfocado_ok then
  vim.g.enfocado_style = 'neon'
end

vim.cmd [[
try
  colorscheme kanagawa 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
