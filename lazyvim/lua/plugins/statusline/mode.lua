local colors = require("plugins.statusline.colors")
local hl = colors.highlight

local mode = setmetatable({
    n = "normal",
    no = "op",
    nov = "op",
    noV = "op",
    ["no"] = "op",
    niI = "normal",
    niR = "normal",
    niV = "normal",
    nt = "normal",
    v = "visual",
    V = "visual_lines",
    [""] = "visual_block",
    s = "select",
    S = "select",
    [""] = "block",
    i = "insert",
    ic = "insert",
    ix = "insert",
    R = "replace",
    Rc = "replace",
    Rv = "v_replace",
    Rx = "replace",
    c = "command",
    cv = "command",
    ce = "command",
    r = "enter",
    rm = "more",
    ["r?"] = "confirm",
    ["!"] = "shell",
    t = "terminal",
    ["null"] = "none",
}, {
    __call = function(self, raw_mode)
        return self[raw_mode]
    end,
})

local mode_lable = {
    normal = "NORMAL",
    op = "OP",
    visual = "VISUAL",
    visual_lines = "VLINES",
    visual_block = "VBLOCK",
    select = "SELECT",
    block = "BLOCK",
    insert = "INSERT",
    replace = "REPLACE",
    v_replace = "V-REPLACE",
    command = "COMMAND",
    enter = "ENTER",
    more = "MORE",
    confirm = "CONFIRM",
    shell = "SHELL",
    terminal = "TERMINAL",
    none = "NONE",
}

local Space = { provider = " " }

local VimMode = {
    init = function(self)
        self.mode = mode[vim.api.nvim_get_mode().mode] -- :h mode()
    end,
    update = { "ModeChanged" },
    Space,
    {
        provider = function(self)
            return mode_lable[self.mode]
        end,
    },
    hl = function(self)
        return hl.Mode[self.mode]
    end,
    Space,
}

return VimMode
