-- You can simply override any internal plugins using Lazy, here are some example operations:
return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "███╗   ██╗██╗ ██████╗██╗  ██╗██╗     ██╗ ██████╗ ██╗   ██╗",
        "████╗  ██║██║██╔════╝██║  ██║██║     ██║██╔═══██╗██║   ██║",
        "██╔██╗ ██║██║██║     ███████║██║     ██║██║   ██║██║   ██║",
        "██║╚██╗██║██║██║     ██╔══██║██║██   ██║██║   ██║██║   ██║",
        "██║ ╚████║██║╚██████╗██║  ██║██║╚█████╔╝╚██████╔╝╚██████╔╝",
        "╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝ ╚════╝  ╚═════╝  ╚═════╝ ",
      }

      local get_icon = require("astroui").get_icon
      opts.section.buttons.val = {
        opts.button("n", get_icon("FileNew", 2, true) .. "New File  ", ":ene <BAR> startinsert <CR>"),
        opts.button(
          "f",
          get_icon("Search", 2, true) .. "Find File  ",
          ':lua require("telescope.builtin").find_files() <CR>'
        ),
        opts.button(
          "o",
          get_icon("DefaultFile", 2, true) .. "Recents  ",
          ':lua require("telescope.builtin").oldfiles() <CR>'
        ),
        opts.button(
          "w",
          get_icon("WordFile", 2, true) .. "Find Word  ",
          ':lua require("telescope.builtin").live_grep() <CR>'
        ),
        opts.button("s", get_icon("Refresh", 2, true) .. "Last Session  ", "<cmd>lua require('resession').load()<cr>"),
        opts.button(
          "  c",
          "  Configurations",
          ':lua require("telescope.builtin").find_files({cwd=vim.fn.stdpath("config")}) <CR>'
        ),
        opts.button("  l", "󰒲  Lazy", ":Lazy <CR>"),
        opts.button("  q", "󰿅  Quit", ":qa <CR>"),
      }

      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.file_ignore_patterns = { "node_modules", "dist", "build" }
      opts.defaults.prompt_prefix = "  "
      opts.defaults.selection_caret = "󰈺 "

      return opts
    end,
  },

  -- term
  {
    "akinsho/toggleterm.nvim",
    keys = {
      [[<c-\>]]
    },
    opts = function(_, opts)
      opts.open_mapping = [[<c-\>]]
      opts.direction = 'horizontal'
      return opts
    end
  },

  -- notify
  {
    "rcarriga/nvim-notify",
    opts = function (_, opts)
      opts.top_down = false
      return opts
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function (_, opts)
      opts.filesystem.follow_current_file = { enabled = false }
      opts.window.mappings = {
        h = false,
        j = false,
        k = false,
        l = false,
        v = false,
        g = false,
        w = false,
        e = false,
      }
      return opts
    end
  },
  {
    "AstroNvim/astroui",
    opts = function (_, opts)
      opts.status.separators.breadcrumbs = " > "
      opts.status.separators.path = " > "
      return opts
    end
  },
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
				    }
			    end,
		    })
		    vim.cmd.colorscheme("kanagawa")
	    end,
  }
}
