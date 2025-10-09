return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        enabled = false,
        lazy = false,
        version = false, -- Never set this value to "*"! Never!
        opts = {
            provider = "gemini-cli",
            acp_providers = {
                ["gemini-cli"] = {
                    command = "gemini",
                    args = { "--experimental-acp" },
                    env = {
                        NODE_NO_WARNINGS = "1",
                    },
                    auth_method = nil,
                },
            },
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
    },
}
