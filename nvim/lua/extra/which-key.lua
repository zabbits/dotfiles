return {
    "folke/which-key.nvim",
    keys = { "<leader>", "g", "[", "]" },
    config = function()
        local wk = require("which-key")
        wk.setup({
            preset = "helix",
        })
        wk.add({
            { "<leader>f", group = "Find" },
            { "<leader>r", group = "Overseer" },
            { "<leader>s", group = "Session " },
            { "<leader>x", group = "Trouble" },
        })
    end,
}
