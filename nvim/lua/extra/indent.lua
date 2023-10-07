return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufRead", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
            },
            exclude = {
                filetypes = {
                    "trouble",
                    "Trouble",
                },
            },
            scope = {
                enabled = false,
            },
        },
    },
    {
        "echasnovski/mini.indentscope",
        event = { "BufRead", "BufNewFile" },
        opts = {
            -- disable mappings
            mappings = {
                object_scope = "",
                object_scope_with_border = "",
                goto_top = "",
                goto_bottom = "",
            },
            symbol = "│",
        },
    },
}
