return {
    -- dir = "~/github/heirline.nvim/",
    "zabbits/heirline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
        vim.o.laststatus = 3

        local Mode = require("extra.statusline.mode")
        local File = require("extra.statusline.file")
        local Diagnostic = require("extra.statusline.diagnostic")
        local Git = require("extra.statusline.git")
        local Lsp = require("extra.statusline.lsp")
        local misc = require("extra.statusline.misc")
        local Winbar = require("extra.statusline.winbar")

        local colors = require("extra.statusline.colors")
        local hl = colors.highlight

        local Align = { provider = "%=" }
        local Space = setmetatable({ provider = " " }, {
            __call = function(_, n)
                return { provider = string.rep(" ", n) }
            end,
        })
        local Statusline = {
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
            Space,
            Lsp,
            Space,
            misc.TabSize,
            Space,
            misc.FileProperties,
            Space,
            misc.Percent,
            misc.ModifiableIndicator,
        }

        local conditions = require("heirline.conditions")
        require("heirline").setup({
            statusline = Statusline,
            winbar = Winbar,
            opts = {
                disable_winbar_cb = function(args)
                    return conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
                        filetype = {
                            "^git.*",
                            "fugitive",
                            "Trouble",
                            "dashboard",
                            "neo-tree",
                            "lazy",
                            "mason",
                            "toggleterm",
                        },
                    }, args.buf)
                end,
            },
        })
    end,
}
