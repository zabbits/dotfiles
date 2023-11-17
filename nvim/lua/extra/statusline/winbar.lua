local get_hl = require("aerial.highlight").get_highlight
local colors = require("extra.statusline.colors").colors

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
                            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), {line, col})
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

return Aerial
