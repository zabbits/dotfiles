return {
    "stevearc/aerial.nvim",
    lazy = true,
    cmd = { "Aerial", "AerialToggle" },
    -- Optional dependencies
    keys = {
        { "go", "<cmd>AerialToggle<cr>", "Aerial" },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        layout = {
            min_width = 30,
        },
        filter_kind = {
            "Class",
            "Constructor",
            "Enum",
            "Function",
            "Interface",
            "Module",
            "Method",
            "Struct",
            "Namespace",
            "Package",
        },
    },
}
