return {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
        { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find Word" },
        { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find OldFiles" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
        {
            "<leader>fc",
            function()
                require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "node_modules", "dist", "build", "target" },
                prompt_prefix = "  ",
                selection_caret = "󰈺 ",
                path_display = { "truncate" },
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.85,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.85,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-c>"] = actions.close,
                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                    },
                    n = {
                        ["<esc>"] = actions.close,
                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["j"] = actions.move_selection_next,
                        ["k"] = actions.move_selection_previous,
                        ["H"] = actions.move_to_top,
                        ["M"] = actions.move_to_middle,
                        ["L"] = actions.move_to_bottom,
                        ["gg"] = actions.move_to_top,
                        ["G"] = actions.move_to_bottom,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                    },
                },
            },
        })
        telescope.load_extension("fzf")
    end,
}
