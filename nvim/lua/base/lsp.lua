return {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    init = function()
        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true, noremap = true }
                -- if trouble plugin exist
                local ok, _ = pcall(require, "trouble")
                if ok then
                    vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<cr>", opts)
                    vim.keymap.set("n", "gt", "<cmd>Trouble lsp_type_definitions<cr>", opts)
                else
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
                end

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "gm", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)

                -- jump diagnostic
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]e", function()
                    vim.diagnostic.goto_next({ severity = { vim.diagnostic.severity.ERROR } })
                end, opts)
                vim.keymap.set("n", "[e", function()
                    vim.diagnostic.goto_prev({ severity = { vim.diagnostic.severity.ERROR } })
                end, opts)
            end,
        })
    end,
    config = function()
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
