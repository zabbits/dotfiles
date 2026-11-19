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
        keys = {
            {
                "<leader>E",
                "<cmd>Neotree toggle float<cr>",
                desc = "FileTree",
            },
            {
                "<leader>e",
                "<cmd>Neotree focus reveal float<cr>",
                desc = "FileTree Reveal",
            },
            { "<C-e>", "<cmd>Neotree buffers float<cr>", desc = "Buffers" },
        },
        opts = {
            filesystem = {
                hijack_netrw_behavior = "open_default",
                bind_to_cwd = true,
            },
            enable_diagnostics = false,
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
                    ["z"] = "none",
                    ["c"] = "copy_to_clipboard",
                },
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
        opts = {
            "borderless_full",
            winopts = {
                -- preview = {
                --     layout = "vertical",
                --     vertical = "down:65%",
                -- },
                on_create = function()
                    -- use Ctrl-r paste register
                    vim.keymap.set(
                        "t",
                        "<C-r>",
                        [['<C-\><C-N>"'.nr2char(getchar()).'pi']],
                        { expr = true, buffer = true }
                    )
                end,
            },
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
