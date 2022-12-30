local M = {
  'tiagovla/tokyodark.nvim',
  lazy = false,
  dependencies = {
    'rebelot/kanagawa.nvim',
  },
}

local function set_kanagawa()
  local kanagawa = safe_require('kanagawa')
  local colors = safe_require('kanagawa.colors').setup()
  if kanagawa then
    kanagawa.setup({
      undercurl = false, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true, bold = false },
      statementStyle = { bold = false },
      typeStyle = {},
      variablebuiltinStyle = { italic = true },
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      globalStatus = true, -- adjust window separators highlight for laststatus=3
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {},
      theme = "default", -- Load "default" theme or the experimental "light" theme
    })

    M.bg = colors.bg
    M.fg = colors.fg
    return 'kanagawa'
  end

  return 'default'
end

function M.config()
  vim.cmd.colorscheme("tokyodark")
  -- vim.cmd.colorscheme(set_kanagawa())
end

return M
