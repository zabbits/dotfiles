return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble doc" },
        { "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Trouble workspace" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble loc" },
        { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Trouble qf" },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
        {
            "<leader>xp",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
    },
    opts = {
        mode = "document_diagnostics",
        use_diagnostic_signs = true,
    },
}
