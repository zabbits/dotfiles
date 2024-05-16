return {
    "stevearc/overseer.nvim",
    keys = {
        { "<leader>rr", "<cmd>OverseerRun<cr>", desc = "OverseerRun" },
        { "<leader>ro", "<cmd>OverseerToggle<cr>", desc = "OverseerToggle" },
        { "<leader>ra", "<cmd>OverseerQuickAction<cr>", desc = "OverseerAction" },
    },
    opts = {
        templates = {
            "builtin",
            "user.cpp_run",
            "user.cpp_build",
            "user.cpp_run_folder",
            "user.cpp_build_folder",
        },
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
