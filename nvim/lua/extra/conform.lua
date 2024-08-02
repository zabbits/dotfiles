return {
    "stevearc/conform.nvim",
    lazy = true,
    keys = {
        {
            "gq",
            function()
                require("conform").format({ lsp_fallback = true })
            end,
            desc = "Format",
        },
    },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                cpp = { "clang_format" },
                c = { "clang_format" },
                html = { "prettierd" },
                css = { "prettierd" },
                json = { "prettierd" },
            },
        })
    end,
}
