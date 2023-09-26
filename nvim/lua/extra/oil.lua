return {
    "stevearc/oil.nvim",
    lazy = true,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        vim.z.map("n", "<leader>e", function()
            require("oil").open()
        end, "Oil Open")
    end,
    opts = {},
}
