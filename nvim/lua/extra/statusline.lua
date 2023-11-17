return {
    "rebelot/heirline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
        vim.o.laststatus = 3

        local Mode = require("extra.statusline.mode")
        local File = require("extra.statusline.file")
        local Diagnostic = require("extra.statusline.diagnostic")
        local Git = require("extra.statusline.git")
        local Lsp = require("extra.statusline.lsp")
        local misc  = require("extra.statusline.misc")

        local colors = require("extra.statusline.colors")
        local hl = colors.highlight

        local Align = { provider = "%=" }
        local Space = setmetatable({ provider = " " }, {
            __call = function(_, n)
                return { provider = string.rep(" ", n) }
            end,
        })
        local statusline = {
            hl = hl.StatusLine,
            static = {
                ReadOnly = {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = "",
                    hl = hl.ReadOnly,
                },
            },
            Mode,
            Space,
            File,
            Space,
            Git,
            Space,
            Diagnostic,
            Align,
            Lsp,
            Space,
            misc.TabSize,
            Space,
            misc.ModifiableIndicator,
            Space,
            misc.FileProperties,
            Space,
            misc.Location,
        }
        require("heirline").setup({
            statusline = statusline,
        })
    end,
}
