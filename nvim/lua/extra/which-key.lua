return {
    "folke/which-key.nvim",
    keys = { "<leader>", "g", "[", "]" },
    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>"] = {
                f = { name = "Find" },
                s = { name = "Session " },
                l = { name = "LeetCode" },
                x = { name = "Trouble" },
                r = { name = "Overseer" },
            },
        })
    end,
}
