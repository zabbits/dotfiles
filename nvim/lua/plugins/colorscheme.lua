return {
  { "catppuccin/nvim", enabled = false },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = { italic = true },
        colors = {
          palette = {
            oldWhite = "#CCCCCC",
            fujiWhite = "#B6B6B6",
          },
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
                bg = "#11121D",
                pmenu = {
                  fg = "#619ac3",
                  bg = "#11121D",
                },
                float = {
                  fg = "#619ac3",
                  bg = "#11121D",
                },
              },
              syn = {
                identifier = "#45b787",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          local palette = colors.palette
          return {
            LspInlayHintxxx = { bg = "#11121D" },
            StatusLine = { bg = theme.ui.bg_visual },
            -- StatusLine = { bg = theme.ui.bg_visual },
            WinSeparator = { fg = theme.ui.bg_p1 },

            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m2 },
            LazyNormal = { bg = theme.ui.bg_m2, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m2, fg = theme.ui.fg_dim },

            TelescopeMatching = { fg = palette.springBlue, sp = palette.springBlue },
            TelescopePromptTitle = { fg = palette.sumiInk0, bg = palette.oniViolet, bold = true, italic = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopePromptPrefix = { fg = palette.springBlue, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopeResultsTitle = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewTitle = {
              fg = palette.sumiInk0,
              bg = palette.springBlue,
              bold = true,
              italic = true,
            },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            illuminatedWord = { bg = theme.ui.bg_p2 },
            illuminatedCurWord = { bg = theme.ui.bg_p2 },
            IlluminatedWordText = { bg = theme.ui.bg_p2 },
            IlluminatedWordRead = { bg = theme.ui.bg_p2 },
            IlluminatedWordWrite = { bg = theme.ui.bg_p2 },

            CmpItemAbbrMatch = { fg = theme.syn.type },
            CmpItemAbbrMatchFuzzy = { fg = theme.syn.type },

            ["@lsp.type.magicFunction"] = { link = "@method" },
            ["@lsp.typemod.function.builtin"] = { link = "@method" },
            ["@lsp.typemod.function.defaultLibrary"] = { link = "@method" },
            ["@lsp.typemod.method.defaultLibrary"] = { link = "@method" },
          }
        end,
      })
    end,
  },
}
