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
    {
        "neovim/nvim-lspconfig",
        opts = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            -- change a keymap
            keys[#keys + 1] = {
                "K",
                function()
                    vim.lsp.buf.hover({ border = "single" })
                end,
            }
            -- disable a keymap
            -- keys[#keys + 1] = { "K", false }
            -- add a keymap
            -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
        end,
    },
}
