return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
        {"<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble"},
        {"<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble doc"},
        {"<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace"},
        {"<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble loc"},
        {"<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble qf"},
    },
    opts = {
        mode = "document_diagnostics",
        use_diagnostic_signs = true,
    },
}
