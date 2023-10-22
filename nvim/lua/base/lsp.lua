return {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
        -- keymaps
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true, noremap = true }
                -- if trouble plugin exist
                if require("lazy.core.config").plugins["trouble.nvim"] then
                    vim.z.mapo("n", "gr", "<cmd>Trouble lsp_references<cr>", "LSP ref", opts)
                    vim.z.mapo("n", "gd", "<cmd>Trouble lsp_definitions<cr>", "LSP def", opts)
                    vim.z.mapo("n", "gt", "<cmd>Trouble lsp_type_definitions<cr>", "LSP type", opts)
                else
                    vim.z.map("n", "gr", vim.lsp.buf.references, "LSP ref", opts)
                    vim.z.map("n", "gd", vim.lsp.buf.definition, "LSP def", opts)
                    vim.z.map("n", "gt", vim.lsp.buf.type_definition, "LSP type", opts)
                end

                vim.z.map("n", "gD", vim.lsp.buf.declaration, "LSP declaration", opts)
                vim.z.map("n", "K", vim.lsp.buf.hover, "Hover", opts)
                vim.z.map("n", "gi", vim.lsp.buf.implementation, "LSP impl", opts)
                vim.z.map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help", opts)
                vim.z.map("n", "gm", vim.lsp.buf.rename, "Lsp rename", opts)
                vim.z.map({ "n", "v" }, "ga", vim.lsp.buf.code_action, "Code action", opts)

                -- jump diagnostic
                vim.z.map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic", opts)
                vim.z.map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic", opts)
                vim.z.map("n", "]e", function()
                    vim.diagnostic.goto_next({ severity = { vim.diagnostic.severity.ERROR } })
                end, "Next error", opts)
                vim.z.map("n", "[e", function()
                    vim.diagnostic.goto_prev({ severity = { vim.diagnostic.severity.ERROR } })
                end, "Prev error", opts)
            end,
        })

        -- ui
        local _border = "single"
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = _border,
        })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = _border,
        })
        vim.diagnostic.config({
            underline = false,
            update_in_insert = true,
            float = { border = _border },
        })
    end,
}
