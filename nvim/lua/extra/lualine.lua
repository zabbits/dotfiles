return {
    "nvim-lualine/lualine.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                {
                    "filename",
                    symbols = {
                        modified = "", -- Text to show when the file is modified.
                        readonly = "", -- Text to show when the file is non-modifiable or readonly.
                        unnamed = "[No Name]", -- Text to show for unnamed buffers.
                        newfile = "", -- Text to show for newly created file before first write
                    },
                },
            },
            lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        extensions = {
            "aerial",
            "lazy",
            "trouble",
            "toggleterm",
            "quickfix",
            "neo-tree",
        },
    },
}
