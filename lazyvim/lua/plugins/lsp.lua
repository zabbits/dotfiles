return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                -- virtual_lines = {
                --     current_line = true,
                -- },
                -- virtual_text = {
                --     current_line = false,
                -- },
                virtual_text = false,
                severity_sort = true,
                underline = false,
                float = { border = "single" },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ["*"] = {
                    keys = {
                        {
                            "K",
                            function()
                                vim.lsp.buf.hover({ border = "single" })
                            end,
                        },
                    },
                },
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "ghost",
                options = {
                    show_source = {
                        enabled = true,
                    },
                    show_all_diags_on_cursorline = true,
                },
            })
        end,
    },
}
