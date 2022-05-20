local M = {}

function M.config()
  local scheme = 'default'

  local kanagawa = _G.safe_require('kanagawa')
  local colors = _G.safe_require('kanagawa.colors').setup()
  if kanagawa and colors then
    scheme = 'kanagawa'
    kanagawa.setup({
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
