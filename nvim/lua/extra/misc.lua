return {
    {
        "ojroques/nvim-osc52",
        keys = {"<leader>y", mode = "n,v,s"},
        config = function()
            vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
            vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
            vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)
        end,
    }
}
