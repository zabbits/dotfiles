return {
    "stevearc/overseer.nvim",
    keys = {
        { "<leader>or", "<cmd>OverseerRun<cr>", desc = "OverseerRun" },
        { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "OverseerToggle" },
        { "<leader>oa", "<cmd>OverseerQuickAction<cr>", desc = "OverseerAction" },
    },
    opts = {
        templates = { "builtin", "user.cpp_build", "user.cpp_run", "user.cpp_build_run" },
        task_list = {
            bindings = {
                ["<C-l>"] = false,
                ["<C-h>"] = false,
                ["L"] = "IncreaseDetail",
                ["H"] = "DecreaseDetail",
            },
        },
    },
}
