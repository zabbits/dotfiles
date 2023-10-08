return {
    "stevearc/overseer.nvim",
    keys = {
        { "<leader>or", "<cmd>OverseerRun<cr>", desc = "OverseerRun" },
    },
    opts = {
        templates = { "builtin", "user.cpp_build", "user.cpp_run"  },
    },
}
