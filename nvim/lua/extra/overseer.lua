return {
    {
        "stevearc/overseer.nvim",
        lazy = true,
        keys = {
            { "<leader>;", "<cmd>OverseerToggle<cr>", desc = "OverseerRun" },
            { "<leader>r", "<cmd>OverseerRun<cr>",    desc = "OverseerRun" },
        },
        opts = {
            templates = {
                "builtin",
                "user.c_run",
                "user.c_build",
                "user.cpp_run",
                "user.cpp_build",
                "user.cpp_run_folder",
                "user.cpp_build_folder",
            },
            task_list = {
                -- Default direction. Can be "left", "right", or "bottom"
                direction = "bottom",
                bindings = {
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["<C-u>"] = "ScrollOutputUp",
                    ["<C-d>"] = "ScrollOutputDown",
                    ["L"] = "IncreaseDetail",
                    ["H"] = "DecreaseDetail",
                },
            },
        },
    }
}
