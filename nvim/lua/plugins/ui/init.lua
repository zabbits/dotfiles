local hexChars = "0123456789abcdef"
local function hex_to_rgb(hex)
	hex = string.lower(hex)
	local ret = {}
	for i = 0, 2 do
		local char1 = string.sub(hex, i * 2 + 2, i * 2 + 2)
		local char2 = string.sub(hex, i * 2 + 3, i * 2 + 3)
		local digit1 = string.find(hexChars, char1) - 1
		local digit2 = string.find(hexChars, char2) - 1
		ret[i + 1] = (digit1 * 16 + digit2) / 255.0
	end
	return ret
end

local rgb_to_hex = function(tuple)
	local h = "#"
	for i = 1, 3 do
		local c = math.floor(tuple[i] * 255 + 0.5)
		local digit2 = math.fmod(c, 16)
		local x = (c - digit2) / 16
		local digit1 = math.floor(x)
		h = h .. string.sub(hexChars, digit1 + 1, digit1 + 1)
		h = h .. string.sub(hexChars, digit2 + 1, digit2 + 1)
	end
	return h
end

local fade = function(hex, factor)
	if not factor then
		factor = 0.2
	end
	local rgb = hex_to_rgb(hex)
	return rgb_to_hex({ rgb[1] * (1 - factor), rgb[2] * (1 - factor), rgb[3] * (1 - factor) })
end

local theme_conf = {
	"tiagovla/tokyodark.nvim",
	lazy = false,
	dependencies = {},
	config = function()
		vim.cmd.colorscheme("tokyodark")
		local p = require("tokyodark.palette")
		-- highlight for illuminate
		for _, group in pairs({
			"illuminatedWord",
			"illuminatedCurWord",
			"IlluminatedWordText",
			"IlluminatedWordRead",
			"IlluminatedWordWrite",
		}) do
			vim.api.nvim_set_hl(0, group, { bg = p.grey })
		end
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
				':lua require("telescope.builtin").find_files({cwd="$HOME/.config/nvim/"}) <CR>'
			),
			dashboard.button("  l", "  Lazy", ":Lazy <CR>"),
			dashboard.button("  q", "  Quit", ":qa <CR>"),
		}

		-- Foot must be a table so that its height is correctly measured
		-- local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
		-- local num_plugins_tot = #vim.tbl_keys(packer_plugins)
		-- if num_plugins_tot <= 1 then
		--   dashboard.section.footer.val = { num_plugins_loaded .. ' / ' .. num_plugins_tot .. ' plugin ﮣ loaded' }
		-- else
		--   dashboard.section.footer.val = { num_plugins_loaded .. ' / ' .. num_plugins_tot .. ' plugins ﮣ loaded' }
		-- end
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
