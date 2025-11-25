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
        "A7Lavinraj/fyler.nvim",
        dependencies = { "nvim-mini/mini.icons" },
        branch = "stable", -- Use stable branch for production
        lazy = true,
        keys = {
            {
                "<leader>e",
                function()
                    require("fyler").open({ kind = "split_left_most" })
                end,
                desc = "Aerial (Symbols)",
            },
        },
        opts = {
            hooks = {},
            integrations = {
                icon = "mini_icons",
            },
            views = {
                finder = {
                    win = {
                        border = vim.o.winborder == "" and "single" or vim.o.winborder,
                        kinds = {
                            float = {
                                height = "70%",
                                width = "70%",
                                top = "10%",
                                left = "15%",
                            },
                            split_left = {
                                width = "15%",
                            },
                            split_left_most = {
                                width = "15%",
                                win_opts = {
                                    winfixwidth = true,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "folke/snacks.nvim",
        keys = {
            { "<leader>e", false },
            { "<leader>E", false },
            { "<C-e>", LazyVim.pick("buffers"), desc = "Buffers" },
            { "<leader>/", LazyVim.pick("files", { hidden = true }), desc = "Grep (With Hidden)" },
            { "<leader>:", LazyVim.pick("grep", { hidden = true }), desc = "Find Files (With Hidden)" },
            { "<leader><leader>", "<C-^>", desc = "Alternate file" },
            { "<leader>fo", LazyVim.pick("oldfiles"), desc = "Recent" },
        },
        opts = {
            animate = { enabled = false },
            indent = { enabled = false },
            scope = { enabled = false },
            scroll = { enabled = false },
            words = { enabled = false },
            dashboard = { enabled = false },
            picker = {
                sources = {
                    explorer = {
                        -- your explorer picker configuration comes here
                        -- or leave it empty to use the default settings
                        diagnostics = false,
                        win = {
                            list = {
                                keys = {
                                    ["<BS>"] = "explorer_up",
                                    ["C"] = "explorer_close", -- close directory
                                    ["y"] = { "explorer_yank", mode = { "n" } },
                                },
                            },
                        },
                    },
                },
            },
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
}
