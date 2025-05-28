return {
    "neovim/nvim-lspconfig",
    -- event = { "BufRead", "BufNewFile" },
    event = "VeryLazy",
    config = function()
        -- keymaps
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true, noremap = true }

                -- vim.z.map("n", "gD", vim.lsp.buf.declaration, "LSP declaration", opts)
                vim.z.map("n", "K", function()
                    vim.lsp.buf.hover({ border = "single" })
                end, "Hover", opts)
                -- vim.z.map("n", "gi", vim.lsp.buf.implementation, "LSP impl", opts)
                vim.z.map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help", opts)
                vim.z.map("n", "gm", vim.lsp.buf.rename, "Lsp rename", opts)

                vim.z.map({ "n", "v" }, "ga", vim.lsp.buf.code_action, "Code action", opts)
                -- jump diagnostic
                vim.z.map("n", "]d", function()
                    vim.diagnostic.jump({ count = 1, float = false })
                end, "Next diagnostic", opts)
                vim.z.map("n", "[d", function()
                    vim.diagnostic.jump({ count = -1, float = false })
                end, "Prev diagnostic", opts)
                vim.z.map("n", "]e", function()
                    vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
                end, "Next error", opts)
                vim.z.map("n", "[e", function()
                    vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
                end, "Prev error", opts)

                -- toggle inlay hints
                vim.z.map("n", "gh", function ()
                    if vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) then
                        vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
                    else
                        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
                    end
                end, "Toggle inaly hints", opts)
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
        local icons = require("core.icons")
        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            underline = false,
            update_in_insert = true,
            float = { border = _border },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.lsp.error,
                    [vim.diagnostic.severity.WARN] = icons.lsp.warn,
                    [vim.diagnostic.severity.HINT] = icons.lsp.hint,
                    [vim.diagnostic.severity.INFO] = icons.lsp.info,
                },
            },
        })
    end,
}
