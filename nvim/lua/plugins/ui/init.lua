local theme_conf = {
	"rebelot/kanagawa.nvim",
	lazy = false,
	-- dependencies = { "tiagovla/tokyodark.nvim" },
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
				theme = {
					all = {
						ui = {
							-- fg = "#bdaead",
							fg = "#33a6b8",
							bg_gutter = "none",
							bg = "#11121D",
							-- bg = "#161823",
							-- bg = "#131124",
							pmenu = {
								bg = "#161823",
							},
						},
						syn = {
							identifier = "#7cabb1",
							type = "#43b244",
              fun = "#51a8dd",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					StatusLine = { bg = theme.ui.bg_visual },

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

					illuminatedWord = { bg = theme.ui.bg_p2 },
					illuminatedCurWord = { bg = theme.ui.bg_p2 },
					IlluminatedWordText = { bg = theme.ui.bg_p2 },
					IlluminatedWordRead = { bg = theme.ui.bg_p2 },
					IlluminatedWordWrite = { bg = theme.ui.bg_p2 },

					["@lsp.type.magicFunction"] = { link = "@method" },
					["@lsp.typemod.function.builtin"] = { link = "@method" },
					["@lsp.typemod.function.defaultLibrary"] = { link = "@method" },
					["@lsp.typemod.method.defaultLibrary"] = { link = "@method" },
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
				-- vim.opt.showtabline = 0
				vim.opt.laststatus = 0
			end,
		})

		vim.api.nvim_create_autocmd("BufUnload", {
			pattern = "<buffer>",
			callback = function()
				-- vim.opt.showtabline = 2
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
			indicator = { style = "underline" },
			-- separator_style = "slope",
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
		highlights = {},
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
				"notify",
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
	-- bufferline_conf,
	nui_conf,
	indent_conf,
	heirline_conf,
	noice_conf,
}
