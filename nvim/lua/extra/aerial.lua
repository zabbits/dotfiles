return {
    "stevearc/aerial.nvim",
    lazy = true,
    -- Optional dependencies
    init = function()
        vim.z.map("n", "go", "AerialToggle!")
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("aerial").setup({})
    end,
}
