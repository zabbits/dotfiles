return {
    {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        ft = { "rust" },
        init = function()
            vim.g.rustaceanvim = {
                tools = {
                    float_win_config = {
                        border = "single"
                    }
                }
            }
        end,
    },
    -- crates support
    {
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup()
        end,
    },
}
