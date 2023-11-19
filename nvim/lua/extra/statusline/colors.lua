local heirline = require("heirline.utils")
local get_hl = heirline.get_highlight
local M = {} -- theme

local colors = {}
do
    colors.fg1 = "#f0dec2"
    colors.grey3 = "#b0a392"
    colors.black = "#282828"
    colors.blue2 = "#64af9c"
    colors.grey0 = "#7c6f64"
    colors.grey1 = "#928374"
    colors.grey2 = "#a89984"
    colors.bg_yellow = "#e9b143"
    colors.blue = "#80aa9e"
    colors.aqua = "#8bba7f"
    colors.orange = "#f28534"
    colors.purple = "#d3869b"
    colors.red = "#f2594b"
    colors.yellow = "#e9b143"
    colors.green = "#b0b846"

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

    WorkDir = { fg = colors.grey3, bold = true, italic = true },

    CurrentPath = { fg = get_hl("Directory").fg, bold = true, italic = true },

    FileName = { fg = get_hl("Statusline").fg, bold = true, italic = true },

    FileProperties = { italic = true, fg = colors.purple },

    DapMessages = { fg = get_hl("Debug").fg },

    Git = {
        branch = { fg = colors.purple, bold = true },
        added = { fg = colors.green, bold = true },
        changed = { fg = colors.yellow, bold = true },
        removed = { fg = colors.red, bold = true },
        dirty = { fg = colors.grey2, bold = true },
    },

    LspIndicator = { fg = colors.blue },
    LspServer = { fg = colors.onedark.blue, bold = true },

    Diagnostic = {
        error = { fg = get_hl("DiagnosticSignError").fg },
        warn = { fg = get_hl("DiagnosticSignWarn").fg },
        info = { fg = get_hl("DiagnosticSignInfo").fg },
        hint = { fg = get_hl("DiagnosticSignHint").fg },
    },

    ScrollBar = { bg = colors.aqua, fg = colors.black, bold = true },

    SearchResults = { fg = colors.black, bg = colors.aqua },

    WinBar = get_hl("WinBar"),
}
M.highlight = hl

-- Mode colors
do
    local mode_colors = {
        normal = colors.aqua,
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
        terminal = colors.orange,
        none = colors.red,
    }

    hl.Mode = setmetatable({}, {
        __index = function(_, mode)
            return {
                fg = hl.StatusLine.bg,
                bg = mode_colors[mode],
                bold = true,
            }
        end,
    })
end

M.lsp_colors = {
    sumneko_lua = "#5EBCF6",
    vimls = "#43BF6C",
    ansiblels = "#ffffff",
}

return M
