return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    keys = {
        {
            "gl",
            function()
                require("lsp_lines").toggle()
            end,
            desc = "Lsp lines",
        },
    },
    config = function()
        -- Disable virtual_text since it's redundant due to lsp_lines.
        vim.diagnostic.config({ virtual_text = false })
        require("lsp_lines").setup()
        -- first gl keymap will not toggle it, why???
        require("lsp_lines").toggle()
    end,
}
