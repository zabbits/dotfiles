return {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    init = function()
        vim.z.map("n", "<leader><leader>", "Telescope find_files", "Find Files")
        vim.z.map("n", "<leader>b", "Telescope buffers", "Find Buffers")
        vim.z.map("n", "<leader>fo", "Telescope oldfiles", "Find OldFiles")
        vim.z.map("n", "<leader>fh", "Telescope help_tags", "Find Help")
    end,
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "node_modules", "dist", "build", "target" },
                prompt_prefix = "  ",
                selection_caret = "󰈺 ",
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
