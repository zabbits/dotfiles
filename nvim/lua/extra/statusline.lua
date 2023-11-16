return {
    "rebelot/heirline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
        local vi_mode = require("extra.statusline.mode")
        local file = require("extra.statusline.file")
        local diagnostic = require("extra.statusline.diagnostic")
        local git = require("extra.statusline.git")
        local lsp = require("extra.statusline.lsp")

        local utils = require("heirline.utils")
        local main_bg = utils.get_highlight("StatusLine")
        local space = { provider = " " }
        local align = { provider = "%=" }

        local colors = require("extra.statusline.colors")
        local hl = colors.highlight

        local Space = setmetatable({ provider = " " }, {
            __call = function(_, n)
                return { provider = string.rep(" ", n) }
            end,
        })
        local statusline = {
            static = {
                Null = { provider = "" },
                Align = { provider = "%=" },
                ReadOnly = {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = "",
                    hl = hl.ReadOnly,
                },
            },
            vi_mode,
            Space,
            file,
            Space,
            git,
            -- space,
            -- diagnostic,
            -- align,
            -- lsp,
        }
        require("heirline").setup({
            statusline = statusline,
        })
    end,
}
