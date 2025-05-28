return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        enabled = true,
        lazy = false,
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = "xai",
            vendors = {
                ["xai"] = {
                    __inherited_from = "openai",
                    -- __inherited_from = "openai",
                    api_key_name = "XAI_API_KEY",
                    endpoint = "https://api.x.ai/v1",
                    model = "grok-3-beta",
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
