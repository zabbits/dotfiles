local colors = require("extra.statusline.colors")
local hl = colors.highlight

local Space = setmetatable({ provider = " " }, {
    __call = function(_, n)
        return { provider = string.rep(" ", n) }
    end,
})

local function append(a, b)
    if a and b then
        return a .. " " .. b
    end

    return (a or "") .. (b or "")
end

local FileProperties = {
    condition = function(self)
        self.filetype = vim.bo.filetype
        self.encoding = vim.bo.fileencoding
        local fileformat = vim.bo.fileformat
        if fileformat == "dos" then
            fileformat = "CRLF"
        elseif fileformat == "mac" then
            fileformat = "CR"
        else -- 'unix'
            fileformat = "LF"
        end
        self.fileformat = fileformat
        return self.fileformat or self.encoding or self.filetype
    end,
    provider = function(self)
        return append(append(self.encoding, self.fileformat), self.filetype)
    end,
    hl = hl.FileProperties,
}

local TabSize = {
    provider = function()
        return "Spaces:" .. vim.o.tabstop
    end,
    hl = hl.FileProperties,
}

local Ruler = {
    -- :help 'statusline'
    -- ------------------
    -- %-2 : make item takes at least 2 cells and be left justified
    -- %l  : current line number
    -- %L  : number of lines in the buffer
    -- %c  : column number
    -- %V  : virtual column number as -{num}.  Not displayed if equal to '%c'.
    provider = " %9(%l:%L%)  %-3(%c%V%) ",
    hl = { bold = true },
}

local Location = {
    static = {
        chars = { " ", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" },
    },
    provider = function(self)
        return self.chars[math.ceil(vim.fn.line(".") / vim.fn.line("$") * #self.chars)] or "█"
    end,
    hl = hl.ScrollBar,
}

local ModifiableIndicator = {
    Space,
    provider = function()
        return vim.bo.modifiable and "" or ""
    end,
    hl = hl.ScrollBar,
}

-- TODO: add percent
local Percent = {
    Space,
    provider = "%3(%p%)" .. "%%",
    hl = hl.ScrollBar,
}

return {
    FileProperties = FileProperties,
    TabSize = TabSize,
    Ruler = Ruler,
    Location = Location,
    ModifiableIndicator = ModifiableIndicator,
    Percent = Percent,
}
