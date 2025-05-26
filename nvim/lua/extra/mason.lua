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
        -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local capabilities = require("blink.cmp").get_lsp_capabilities({})

        local mason_registry = require("mason-registry")
        local vue_language_server_path = ""
        if mason_registry.is_installed("vue-language-server") then
            vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
                .. "/node_modules/@vue/language-server"
        end
        vim.lsp.config("*", {
            capabilities = capabilities,
        })
        vim.lsp.config("lua_ls", {
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
        vim.lsp.config("ts_ls", {
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
        vim.lsp.config("volar", {
            capabilities = capabilities,
            init_options = {
                vue = {
                    hybridMode = false,
                },
            },
        })
        require("mason-lspconfig").setup({})
    end,
}

return {
    mason,
    mason_lsp,
}
