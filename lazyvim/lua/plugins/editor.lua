return {
    {
        "stevearc/aerial.nvim",
        keys = {
            { "go", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
        },
    },
    {
        "folke/snacks.nvim",
        keys = {
            { "<leader>/", LazyVim.pick("files", { hidden = true }), desc = "Grep (With Hidden)" },
            { "<leader>:", LazyVim.pick("grep", { hidden = true }), desc = "Find Files (With Hidden)" },
            { "<leader>fo", LazyVim.pick("oldfiles"), desc = "Recent" },
        },
        opts = {
            animate = { enabled = false },
            indent = { enabled = false },
            scope = { enabled = false },
            scroll = { enabled = false },
            words = { enabled = false },
        },
    },
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                {
                    "<leader>w",
                    group = "save",
                    proxy = nil,
                    expand = nil,
                },
            },
        },
    },
    {
        "j-hui/fidget.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {},
    },
}
