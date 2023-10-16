return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<leader>E",
            "<cmd>Neotree toggle<cr>",
            desc = "FileTree",
        },
        {
            "<leader>e",
            "<cmd>Neotree focus reveal<cr>",
            desc = "FileTree Reveal",
        },
    },
    opts = {
        window = {
            mappings = {
                ["e"] = "none",
                ["b"] = "none",
                ["g"] = "none",
                ["w"] = "none",
                ["l"] = "none",
                ["h"] = "none",
                ["v"] = "none",
                ["V"] = "none",
                ["j"] = "none",
                ["k"] = "none",
                ["y"] = "none",
                ["c"] = "copy_to_clipboard",
            },
        },
    },
}
