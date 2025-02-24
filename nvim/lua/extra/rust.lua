return {
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        -- ft = { "rust" },
        lazy = false,
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    float_win_config = {
                        border = "single",
                    },
                },
                server = {
                    default_settings = {
                        -- rust-analyzer language server configuration
                        ["rust-analyzer"] = {
                            -- capabilities = require('blink.cmp').get_lsp_capabilities({}),
                            capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        },
                    },
                    on_attach = function(client, bufnr)
                        -- Set keybindings, etc. here.
                        vim.z.map(
                            { "n", "v" },
                            "ga",
                            "RustLsp codeAction",
                            "Code action",
                            { buffer = bufnr, silent = true, noremap = true }
                        )

                        vim.z.map(
                            { "n", "v" },
                            "K",
                            "RustLsp hover actions",
                            "Lsp hover",
                            { buffer = bufnr, silent = true, noremap = true }
                        )
                    end,
                },
            }
        end,
    },
    -- crates support
    {
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
}
