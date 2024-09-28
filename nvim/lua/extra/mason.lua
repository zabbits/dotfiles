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
        local mason_registry = require("mason-registry")
        local vue_language_server_path = ""
        if mason_registry.is_installed("vue-language-server") then
            vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
                .. "/node_modules/@vue/language-server"
        end

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
            -- install typescript-language-server and vue-language-server
            ["ts_ls"] = function()
                require("lspconfig").ts_ls.setup({
                    capabilities = capabilities,
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = vue_language_server_path,
                                languages = { "vue" },
                            },
                        },
                    },
                })
            end,
            ["volar"] = function()
                require("lspconfig").volar.setup({
                    capabilities = capabilities,
                    init_options = {
                        vue = {
                            hybridMode = false,
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
