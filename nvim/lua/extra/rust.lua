return {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    init = function()
        vim.g.rustaceanvim = {
            on_attach = function(_, bufnr)
                vim.keymap.set({ "n", "v" }, "ga", "<cmd>RustLsp codeAction<cr>", { buffer = bufnr, silent = true })
            end,
        }
    end,
}
