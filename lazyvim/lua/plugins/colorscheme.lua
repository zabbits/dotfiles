return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("kanagawa").setup({
                transparent = false,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                        Pmenu = { fg = theme.ui.shade0, bg = "none" },
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.fg_dim },

                        StatusLine = { link = "Visual" },

                        DiagnosticFloatingError = { link = "DiagnosticError" },
                        DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
                        DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
                        DiagnosticFloatingHint = { link = "DiagnosticHint" },
                        DiagnosticFloatingOk = { link = "DiagnosticOk" },
                    }
                end,
            })
            vim.cmd.colorscheme("kanagawa")
        end,
    },
}
