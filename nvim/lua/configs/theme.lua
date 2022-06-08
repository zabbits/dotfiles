local M = {}

function M.config()
  local scheme = 'default'

  local kanagawa = _G.safe_require('kanagawa')
  local colors = _G.safe_require('kanagawa.colors').setup()
  if kanagawa and colors then
    scheme = 'kanagawa'
    kanagawa.setup({
      undercurl = true, -- enable undercurls
      commentStyle = "NONE",
      functionStyle = "NONE",
      keywordStyle = "NONE",
      statementStyle = "bold",
      typeStyle = "NONE",
      variablebuiltinStyle = "bold",
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      globalStatus = true, -- adjust window separators highlight for laststatus=3
      colors = {},
      overrides = {
        -- Manually add winbar highlight, wait for plugin update
        -- WinBar = { fg = colors.fg_dark, bg = colors.bg_visual, style = "NONE" },
        -- WinBarNC = { fg = colors.fg_comment, bg = colors.bg_status, style = "NONE" },
      }
    })
  end

  vim.cmd("colorscheme " .. scheme)
end

return M
