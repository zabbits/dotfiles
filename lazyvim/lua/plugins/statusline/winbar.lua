local get_hl = require("aerial.highlight").get_highlight
local colors = require("plugins.statusline.colors").colors
local hl = require("plugins.statusline.colors").highlight
local conditions = require("heirline.conditions")

local Align = { provider = "%=" }
local Space = setmetatable({ provider = " " }, {
    __call = function(_, n)
        return { provider = string.rep(" ", n) }
    end,
})

local FileName = {
    init = function (self)
        local current_path = vim.api.nvim_buf_get_name(0)
        self.filename = vim.fn.fnamemodify(current_path, ":t")
        self.active = conditions.is_active()
        self.hl = conditions.is_active() and { fg = hl.StatusLine.bg, bg = colors.aqua } or { fg = hl.StatusLine.bg, bg = colors.grey0 }
    end,
    provider = function(self)
        return self.filename and self.filename ~= "" and " " .. self.filename .. " "
    end,
    hl = { fg = hl.StatusLine.bg, bg = colors.aqua }
}

local Aerial = {
    static = {
        -- bit operation dark magic, see below...
        enc = function(line, col, winnr)
            return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
        end,
        -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
        dec = function(c)
            local line = bit.rshift(c, 16)
            local col = bit.band(bit.rshift(c, 6), 1023)
            local winnr = bit.band(c, 63)
            return line, col, winnr
        end,
    },
    init = function(self)
        local locations = require("aerial").get_location(true)
        local children = {}
        local count = #locations
        for idx, val in ipairs(locations) do
            local loc = {
                -- icon
                {
                    provider = val.icon .. " ",
                    hl = get_hl(val, true, false),
                },
                -- text
                {
                    provider = val.name,
                    hl = { italic = true, bold = true },
                    on_click = {
                        minwid = self.enc(val.lnum, val.col, self.winnr),
                        callback = function(_, minwid)
                            local line, col, winnr = self.dec(minwid)
                            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
                        end,
                        name = "heirline_aerial",
                    },
                },
                -- sep
                {
                    provider = function()
                        return idx ~= count and "  " or ""
                    end,
                    hl = { fg = colors.purple },
                },
            }
            table.insert(children, loc)
        end
        self.child = self:new(children, 1)
    end,
    provider = function(self)
        return self.child:eval()
    end,
    update = { "CursorMoved", "CursorMovedI" },
}

local Winbar = {
    Aerial,
    Space,
    Align,
    FileName
}

return Winbar
