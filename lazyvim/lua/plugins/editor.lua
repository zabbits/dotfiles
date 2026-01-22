return {
    {
        "stevearc/aerial.nvim",
        keys = {
            { "go", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
        },
        opts = {
            layout = {
                min_width = 30,
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            filesystem = {
                bind_to_cwd = true,
            },
        },
    },
    {
        "ibhagwan/fzf-lua",
        keys = {
            { "<leader><leader>", "<C-^>", desc = "Alternate" },
            { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Old Files" },
            { "<leader>fw", "<cmd>FzfLua live_grep<cr>", desc = "Old Files" },
        },
    },
    {
        "folke/snacks.nvim",
        keys = {
            { "<C-e>", LazyVim.pick("buffers"), desc = "Buffers" },
            { "<leader><leader>", "<C-^>", desc = "Alternate file" },
        },
        opts = {
            animate = { enabled = false },
            indent = { enabled = false },
            scope = { enabled = false },
            scroll = { enabled = false },
            words = { enabled = false },
            dashboard = { enabled = false },
        },
    },
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                {
                    "<leader>q",
                    group = "Quit",
                    proxy = nil,
                    expand = nil,
                },
                {
                    "<leader>w",
                    group = "save",
                    proxy = nil,
                    expand = nil,
                },
            },
        },
    },
    {
        "folke/persistence.nvim",
        keys = function()
            return {}
        end,
    },
    {
        "j-hui/fidget.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {},
    },
    {
        "esmuellert/vscode-diff.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
    },
}
