return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                virtual_text = false,
                underline = true,
                update_in_insert = false,
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("tiny-inline-diagnostic").setup()
        end,
    },
}
