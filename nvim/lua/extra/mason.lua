local mason = {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
        {
            "<leader>M",
            "<cmd>Mason<cr>",
            desc = "Mason",
        },
    },
    opts = true,
}

local mason_lsp = {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason-lspconfig").setup({})
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("mason-lspconfig").setup_handlers({
            -- default lsp config
            function(server_name)
                -- using rustaceanvim for rust_analyzer
                if server_name == "rust_analyzer" then
                    return
                end
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ["lua_ls"] = function()
                require("lspconfig").lua_ls.setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = {
                                    "vim",
                                    "require",
                                },
                            },
                        },
                    },
                })
            end,
        })
    end,
}

return {
    mason,
    mason_lsp,
}
