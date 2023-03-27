local theme_conf = {
	"tiagovla/tokyodark.nvim",
	lazy = false,
	dependencies = { "rebelot/kanagawa.nvim" },
	config = function()
		-- vim.cmd.colorscheme("tokyodark")
		local color_gamma = require("tokyodark.utils").color_gamma
		require("kanagawa").setup({
			colors = {
				palette = {
					-- Bg Shades
					sumiInk0 = "#16161D",
					sumiInk1 = "#181820",
					sumiInk2 = "#1a1a22",
					sumiInk3 = "#1F1F28",
					sumiInk4 = "#2A2A37",
					sumiInk5 = "#363646",
					sumiInk6 = "#54546D", --fg

					-- Popup and Floats
					waveBlue1 = "#223249",
					waveBlue2 = "#2D4F67",

					-- Diff and Git
					winterGreen = "#2B3328",
					winterYellow = "#49443C",
					winterRed = "#43242B",
					winterBlue = "#252535",
					autumnGreen = "#76946A",
					autumnRed = "#C34043",
					autumnYellow = "#DCA561",

					-- Diag
					samuraiRed = "#E82424",
					roninYellow = "#FF9E3B",
					waveAqua1 = "#6A9589",
					dragonBlue = "#658594",

					-- Fg and Comments
					oldWhite = "#C8C093",
					fujiWhite = "#DCD7BA",
					fujiGray = "#727169",

					oniViolet = "#957FB8",
					oniViolet2 = "#b8b4d0",
					crystalBlue = "#7E9CD8",
					springViolet1 = "#938AA9",
					springViolet2 = "#9CABCA",
					springBlue = "#7FB4CA",
					lightBlue = "#A3D4D5", -- unused yet
					waveAqua2 = "#7AA89F", -- improve lightness: desaturated greenish Aqua

					-- waveAqua2  = "#68AD99",
					-- waveAqua4  = "#7AA880",
					-- waveAqua5  = "#6CAF95",
					-- waveAqua3  = "#68AD99",

					springGreen = "#98BB6C",
					boatYellow1 = "#938056",
					boatYellow2 = "#C0A36E",
					carpYellow = "#E6C384",

					sakuraPink = "#D27E99",
					waveRed = "#E46876",
					peachRed = "#FF5D62",
					surimiOrange = "#FFA066",
					katanaGray = "#717C7C",

					dragonBlack0 = "#0d0c0c",
					dragonBlack1 = "#12120f",
					dragonBlack2 = "#1D1C19",
					dragonBlack3 = "#181616",
					dragonBlack4 = "#282727",
					dragonBlack5 = "#393836",
					dragonBlack6 = "#625e5a",

					dragonWhite = "#c5c9c5",
					dragonGreen = "#87a987",
					dragonGreen2 = "#8a9a7b",
					dragonPink = "#a292a3",
					dragonOrange = "#b6927b",
					dragonOrange2 = "#b98d7b",
					dragonGray = "#a6a69c",
					dragonGray2 = "#9e9b93",
					dragonGray3 = "#7a8382",
					dragonBlue2 = "#8ba4b0",
					dragonViolet = "#8992a7",
					dragonRed = "#c4746e",
					dragonAqua = "#8ea4a2",
					dragonAsh = "#737c73",
					dragonTeal = "#949fb5",
					dragonYellow = "#c4b28a", --"#a99c8b",
					-- "#8a9aa3",

					lotusInk1 = "#545464",
					lotusInk2 = "#43436c",
					lotusGray = "#dcd7ba",
					lotusGray2 = "#716e61",
					lotusGray3 = "#8a8980",
					lotusWhite0 = "#d5cea3",
					lotusWhite1 = "#dcd5ac",
					lotusWhite2 = "#e5ddb0",
					lotusWhite3 = "#f2ecbc",
					lotusWhite4 = "#e7dba0",
					lotusWhite5 = "#e4d794",
					lotusViolet1 = "#a09cac",
					lotusViolet2 = "#766b90",
					lotusViolet3 = "#c9cbd1",
					lotusViolet4 = "#624c83",
					lotusBlue1 = "#c7d7e0",
					lotusBlue2 = "#b5cbd2",
					lotusBlue3 = "#9fb5c9",
					lotusBlue4 = "#4d699b",
					lotusBlue5 = "#5d57a3",
					lotusGreen = "#6f894e",
					lotusGreen2 = "#6e915f",
					lotusGreen3 = "#b7d0ae",
					lotusPink = "#b35b79",
					lotusOrange = "#cc6d00",
					lotusOrange2 = "#e98a00",
					lotusYellow = "#77713f",
					lotusYellow2 = "#836f4a",
					lotusYellow3 = "#de9800",
					lotusYellow4 = "#f9d791",
					lotusRed = "#c84053",
					lotusRed2 = "#d7474b",
					lotusRed3 = "#e82424",
					lotusRed4 = "#d9a594",
					lotusAqua = "#597b75",
					lotusAqua2 = "#5e857a",
					lotusTeal1 = "#4e8ca2",
					lotusTeal2 = "#6693bf",
					lotusTeal3 = "#5a7785",
					lotusCyan = "#d7e3d8",
				},
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
							-- #1A1B2A
							-- #06080A
							bg = "#11121D",
						},
						syn = {
							variable = "",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					StatusLine = { fg = theme.ui.fg_dim, bg = theme.ui.bg_visual },

					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					illuminatedWord = { bg = theme.ui.bg_visual },
					illuminatedCurWord = { bg = theme.ui.bg_visual },
					IlluminatedWordText = { bg = theme.ui.bg_visual },
					IlluminatedWordRead = { bg = theme.ui.bg_visual },
					IlluminatedWordWrite = { bg = theme.ui.bg_visual },
				}
			end,
		})

		vim.cmd.colorscheme("kanagawa")
	end,
}

local icons_conf = {
	"kyazdani42/nvim-web-devicons",
	config = { default = true },
}

local dressing_conf = {
	"stevearc/dressing.nvim",
	init = function()
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.select(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.input(...)
		end
	end,
}

local alpha_conf = {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "AlphaReady",
			callback = function()
				vim.opt.showtabline = 0
				vim.opt.laststatus = 0
			end,
		})

		vim.api.nvim_create_autocmd("BufUnload", {
			pattern = "<buffer>",
			callback = function()
				vim.opt.showtabline = 2
				vim.opt.laststatus = 3
			end,
		})

		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local header = {
			[[        ,--.      ,--.     ,--.  ,--.                ]],
			[[,--,--, `--' ,---.|  ,---. `--'  `--' ,---. ,--.,--. ]],
			[[|      \,--.| .--'|  .-.  |,--.  ,--.| .-. ||  ||  | ]],
			[[|  ||  ||  |\ `--.|  | |  ||  |  |  |' '-' ''  ''  ' ]],
			[[`--''--'`--' `---'`--' `--'`--'.-'  / `---'  `----'  ]],
			[[                               '---'                 ]],
		}

		dashboard.section.header.val = header

		dashboard.section.buttons.val = {
			dashboard.button("  e", "ﱐ  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("  f", "  Find files", ':lua require("telescope.builtin").find_files() <CR>'),
			dashboard.button("  o", "  Find old files", ':lua require("telescope.builtin").oldfiles() <CR>'),
			dashboard.button("  w", "ﭨ  Live grep", ':lua require("telescope.builtin").live_grep() <CR>'),
			dashboard.button(
				"  s",
				"ﮫ  Sessions",
				':lua require("telescope").extensions.possession.list({initial_mode="normal"}) <CR>'
			),
			dashboard.button(
				"  c",
				"  Configurations",
				':lua require("telescope.builtin").find_files({cwd=vim.fn.stdpath("config")}) <CR>'
			),
			dashboard.button("  l", "  Lazy", ":Lazy <CR>"),
			dashboard.button("  q", "  Quit", ":qa <CR>"),
		}

		dashboard.section.footer.opts.hl = "Comment"

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		local head_butt_padding = 4
		local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
		local header_padding = math.max(0, math.ceil((vim.fn.winheight("$") - occu_height) * 0.25))
		local foot_butt_padding_ub = vim.o.lines - header_padding - occu_height - #dashboard.section.footer.val - 3
		local foot_butt_padding = math.floor((vim.fn.winheight("$") - 2 * header_padding - occu_height))
		foot_butt_padding = math.max(
			0,
			math.max(math.min(0, foot_butt_padding), math.min(math.max(0, foot_butt_padding), foot_butt_padding_ub))
		)

		dashboard.config.layout = {
			{ type = "padding", val = header_padding },
			dashboard.section.header,
			{ type = "padding", val = head_butt_padding },
			dashboard.section.buttons,
			{ type = "padding", val = foot_butt_padding },
			dashboard.section.footer,
		}

		alpha.setup(dashboard.opts)
	end,
}

-- Neovim UI Enhancer
local nui_conf = {
	"MunifTanjim/nui.nvim",
}

-- FIX: notify make first enter buffer issue
local notify_conf = {
	"rcarriga/nvim-notify",
	event = "BufWinEnter",
	config = function()
		local nf = require("notify")
		nf.setup({
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			top_down = false,
		})
		vim.notify = nf
	end,
}

local bufferline_conf = {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-web-devicons", { "tiagovla/scope.nvim", opts = {} } },
	event = { "BufRead", "BufNewFile" },
	opts = {
		options = {
			offsets = {
				{ filetype = "NvimTree", text = "", padding = 1 },
				{ filetype = "neo-tree", text = "Neo-Tree", padding = 1 },
				{ filetype = "Outline", text = "Outline", padding = 1 },
				{ filetype = "Trouble", text = "Trouble", padding = 1 },
			},
			show_buffer_close_icons = false,
			close_icon = "",
			show_close_icon = true,
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 14,
			max_prefix_length = 13,
			show_tab_indicators = true,
			enforce_regular_tabs = false,
			view = "multiwindow",
			show_buffer_icons = true,
			always_show_bufferline = true,
			diagnostics = false,
		},
	},
}

local indent_conf = {
	"echasnovski/mini.indentscope",
	event = "BufReadPre",
	opts = {
		symbol = "│",
		options = { try_as_border = true },
	},
	config = function(_, opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"lspsagafinder",
				"lspsaga",
				"markdown",
				"noice",
				"norg",
				"lspinfo",
				"lspsagaoutline",
				"neotest-summary",
				"neotest-output",
				"neotest-output-panel",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
		require("mini.indentscope").setup(opts)
	end,
}

local heirline_conf = require("plugins.ui.heirline")

local noice_conf = {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"nui.nvim",
		"nvim-notify",
	},
	opts = {
		cmdline = {
			format = {
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			},
		},
		lsp = {
			progress = { enabled = false },
			hover = { enabled = false },
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		routes = {
			{
				view = "mini",
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
			},
			{
				view = "mini",
				filter = {
					mode = "i",
				},
				opts = { skip = true },
			},
			{
				filter = {
					event = "msg_show",
					kind = "search_count",
				},
				opts = { skip = true },
			},
		},
	},
}

return {
	theme_conf,
	icons_conf,
	alpha_conf,
	dressing_conf,
	notify_conf,
	bufferline_conf,
	nui_conf,
	indent_conf,
	heirline_conf,
	noice_conf,
}
