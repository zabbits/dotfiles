return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                virtual_lines = {
                    current_line = true,
                },
                virtual_text = false,
                severity_sort = true,
                underline = false,
                update_in_insert = false,
                float = { border = "single" },
            },
        },
    },
}
