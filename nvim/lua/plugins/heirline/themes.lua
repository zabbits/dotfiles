local heirline = require("heirline.utils")
local get_hl = heirline.get_highlight
local M = {} -- theme

local colors = {}
do
  colors.black = "#282828"
  colors.fg0 = "#e2cca9"
  colors.fg1 = "#f0dec2"
  colors.grey0 = "#7c6f64"
  colors.grey1 = "#928374"
  colors.grey2 = "#a89984"
  colors.grey3 = "#b0a392"
  colors.aqua = "#8bba7f"
  colors.blue = "#80aa9e"
  colors.blue2 = "#64af9c"
  colors.green = "#b0b846"
  colors.orange = "#f28534"
  colors.purple = "#d3869b"
  colors.red = "#f2594b"
  colors.yellow = "#e9b143"
  colors.bg_yellow = "#e9b143"
  colors.bg_green = "#b0b846"
  colors.bg_red = "#db4740"

  colors.bg0 = "#32302f"
  colors.bg1 = "#3c3836"
  colors.bg2 = "#3c3836"
  colors.bg3 = "#504945"
  colors.bg4 = "#504945"
  colors.bg5 = "#665c54"
  colors.bg_current_word = "#45403d"
  colors.bg_diff_blue = "#0f3a42"
  colors.bg_diff_green = "#3d4220"
  colors.bg_diff_red = "#472322"
  colors.bg_statusline1 = "#3c3836"
  colors.bg_statusline2 = "#46413e"
  colors.bg_statusline3 = "#5b534d"
  colors.bg_visual_blue = "#404946"
  colors.bg_visual_green = "#424a3e"
  colors.bg_visual_red = "#543937"
  colors.bg_visual_yellow = "#574833"

  -- Do not delete! It is my addition.
  colors.fg1 = "#f0dec2."
  colors.grey3 = "#b0a392"
  colors.black = "#282828"
  colors.blue2 = "#64af9c"

  colors.onedark = {
    blue = "#8ab7d8",
    green = "#98c369",
    yellow = "#ffff70",
    orange = "#ea9d70",
    purple = "#c475c1",
    red = "#971717",
  }
end
M.colors = colors

local hl = {
  StatusLine = get_hl("Statusline"),

  ReadOnly = { fg = colors.red },

  -- WorkDir = { fg = get_highlight('Comment').fg, bold = true },
  WorkDir = { fg = colors.grey3, bold = true },

  CurrentPath = { fg = get_hl("Directory").fg, bold = true },

  FileName = { fg = colors.green, bold = true },

  -- GPS = { fg = colors.grey2 },

  FileProperties = { fg = colors.blue, bold = true },

  DapMessages = { fg = get_hl("Debug").fg },

  Git = {
    branch = { fg = colors.purple, bold = true },
    added = { fg = colors.green, bold = true },
    changed = { fg = colors.yellow, bold = true },
    removed = { fg = colors.red, bold = true },
    dirty = { fg = colors.grey2, bold = true },
  },

  LspIndicator = { fg = colors.blue },
  LspServer = { bold = false },

  Diagnostic = {
    error = { fg = get_hl("DiagnosticSignError").fg },
    warn = { fg = get_hl("DiagnosticSignWarn").fg },
    info = { fg = get_hl("DiagnosticSignInfo").fg },
    hint = { fg = get_hl("DiagnosticSignHint").fg },
  },

  ScrollBar = { fg = colors.green, bold = true },

  SearchResults = { fg = colors.black, bg = colors.aqua },

  WinBar = get_hl("WinBar"),

  Navic = {
    -- Lable = { fg = colors.grey2 },
    Separator = { fg = colors.grey1 },
  },
}
M.highlight = hl

-- Mode colors
do
  local mode_colors = {
    normal = colors.grey2,
    op = colors.blue,
    insert = colors.blue,
    visual = colors.bg_yellow,
    visual_lines = colors.bg_yellow,
    visual_block = colors.bg_yellow,
    replace = colors.red,
    v_replace = colors.red,
    enter = colors.aqua,
    more = colors.aqua,
    select = colors.purple,
    command = colors.aqua,
    shell = colors.orange,
    term = colors.orange,
    none = colors.red,
  }

  hl.Mode = setmetatable({
    normal = { fg = mode_colors.normal },
  }, {
    __index = function(_, mode)
      return {
        -- fg = colors.black,
        fg = hl.StatusLine.bg,
        bg = mode_colors[mode],
        bold = true,
      }
    end,
  })
end

-- hydra
do
  -- #008080
  -- #00a4a4
  -- #00aeae

  -- #f2594b
  -- #f36c62

  -- #ff1757
  -- #ff476b
  -- #ff5170

  -- #f063b2
  -- #f173b7

  M.hydra = {
    red = "#f36c62",
    amaranth = "#ff5170",
    teal = "#00aeae",
    pink = "#f173b7",
  }
end

M.lsp_colors = {
  sumneko_lua = "#5EBCF6",
  vimls = "#43BF6C",
  ansiblels = "#ffffff",
}

return M
