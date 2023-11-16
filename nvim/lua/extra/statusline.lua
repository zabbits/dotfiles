return {
    "rebelot/heirline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
        local vi_mode = require("extra.statusline.mode")
        local file = require("extra.statusline.file")
        local diagnostic = require("extra.statusline.diagnostic")

        local utils = require("heirline.utils")
        local main_bg = utils.get_highlight("StatusLine")
        local space = { provider = " " }

        local statusline = {
            hl = main_bg,
            vi_mode,
            space,
            space,
            file,
            space,
            diagnostic,
        }
        require("heirline").setup({
            statusline = statusline,
        })
    end,
}
