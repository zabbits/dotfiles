local M = {}

local function set_kanagawa()
  local kanagawa = safe_require('kanagawa')
  local colors = safe_require('kanagawa.colors').setup()
  if kanagawa then
    kanagawa.setup({
      undercurl = true, -- enable undercurls
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
      colors = {},
      overrides = {
      }
    })

    M.bg = colors.bg
    M.fg = colors.fg
    return 'kanagawa'
  end

  return 'default'
end

local function set_zephyr()
  local zephyr = safe_require('zephyr')
  if zephyr then
    M.bg = zephyr.bg
    M.fg = zephyr.fg

    return 'zephyr'
  end

  return 'default'
end

function M.config()
  vim.cmd("colorscheme " .. set_zephyr())
  -- vim.cmd("colorscheme " .. set_kanagawa())
end

return M
