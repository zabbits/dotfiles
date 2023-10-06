return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufRead", "BufNewFile" },
    opts = {
        indent = {
            char = "┆",
        },
        exclude = {
            filetypes = {
                "trouble",
                "Trouble",
            },
        },
    },
}
