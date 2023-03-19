-- ============ treesitter =============
local ts_conf = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufRead", "BufNewFile" },
	dependencies = {
		"windwp/nvim-ts-autotag",
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"HiPhish/nvim-ts-rainbow2",
		-- FIX: for now must using norg as dependencies, otherwise openning neorg file can not get ts info
		"nvim-neorg/neorg",
	},
	config = function()
		local ensure_installed = {
			"c",
			"cpp",
			"rust",
			"go",
			"lua",
			"python",
			"vue",
			"svelte",
			"typescript",
			"javascript",
			"html",
			"css",
			"vim",
			"regex",
			"bash",
			"markdown",
			"markdown_inline",
			"norg",
		}

		local opts = {
			ensure_installed = ensure_installed,
			sync_install = false,
			ignore_install = {},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			matchup = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			},
			indent = {
				enable = true,
				disable = { "yaml", "norg", "org", "python", "c", "json", "go", "java" },
			},
			autotag = {
				enable = true,
			},
			rainbow = {
				enable = true,
				-- list of languages you want to disable the plugin for
				disable = {},
				-- Which query to use for finding delimiters
				query = "rainbow-parens",
				-- Highlight the entire buffer all at once
				strategy = require("ts-rainbow.strategy.global"),
			},
			textobjects = {
				lsp_interop = {
					enable = true,
					border = "none",
					peek_definition_code = {
						["<leader>df"] = "@function.outer",
						["<leader>dF"] = "@class.outer",
					},
				},
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["al"] = "@loop.inner",
						["il"] = "@loop.inner",
					},
					-- You can choose the select mode (default is charwise 'v')
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = false,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
					},
				},
			},
		}

		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup(opts)
	end,
}

-- ============ snip =============
local snip_conf = {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = {
		"honza/vim-snippets",
	},
	config = function()
		require("luasnip.loaders.from_snipmate").lazy_load()
	end,
}

-- ============ cmp =============
local cmp_conf = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			preselect = cmp.PreselectMode.None,
			formatting = {
				format = require("lspkind").cmp_format({
					menu = {
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						path = "[Path]",
						neorg = "[Neorg]",
						latex_symbols = "[LaTeX]",
						crates = "[Crates]",
					},
					maxwidth = 25,
					ellipsis_char = "...",
				}),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			duplicates = {
				nvim_lsp = 1,
				snippy = 1,
				luasnip = 1,
				cmp_tabnine = 1,
				buffer = 1,
				path = 1,
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			window = {
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				completion = {
					border = "rounded",
				},
			},
			experimental = {
				ghost_text = false,
			},
			completion = {
				keyword_length = 1,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "neorg" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "crates" },
			},
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				["<C-y>"] = cmp.config.disable,
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- they way you will only jump inside the snippet region
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
          -- this will make tab to open cmp
					-- elseif has_words_before() then
					-- 	cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
		})
	end,
}

local pair_conf = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "nvim-cmp" },
	config = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		})

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
	end,
}

local comment_conf = {
	"numToStr/Comment.nvim",
	keys = {
		{ "gc", mode = { "n", "v" } },
		{ "gb", mode = { "n", "v" } },
		{ "<C-/>", mode = { "n", "v", "i" } },
	},
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}

local dap_conf = {
	"mfussenegger/nvim-dap",
	enabled = false,
	dependencies = {
		"mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected ", { text = "", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped ", { text = "", texthl = "", linehl = "", numhl = "" })
		local dap = require("dap")
		local dapui = require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
		dapui.setup({
			floating = { border = "rounded" },
		})
	end,
}

local rust_conf = {
	"in-a-day/rust-tools.nvim",
	ft = "rust",
	dependencies = {
		"nvim-lspconfig",
		"plenary.nvim",
	},
	config = function()
		local rt = require("rust-tools")
		local handlers = require("plugins.lsp.handlers")

		local mason_path = vim.env.HOME .. "/.local/share/nvim/mason/packages"
		local codelldb_path = mason_path .. "/codelldb/extension/adapter/codelldb"

		local os = vim.loop.os_uname().sysname:lower()
		local postfix = ".so"
		if os == "darwin" then
			postfix = "dylib"
		end

		local liblldb_path = mason_path .. "/codelldb/extension/lldb/lib/liblldb" .. postfix

		rt.setup({
			hover_actions = {
				auto_focus = true,
			},
			server = {
				settings = {
					["rust-analyzer"] = {
						inlayHints = { locationLinks = false },
					},
				},
				on_attach = handlers.on_attach,
				capabilities = handlers.capabilities,
			},
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		})
	end,
}

local crate_conf = {
	"saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	config = function()
		local crates = require("crates")
		if crates then
			crates.setup()
		end
	end,
}

local neorg_conf = {
	"nvim-neorg/neorg",
	run = ":Neorg sync-parsers", -- This is the important bit!
	cmd = "Neorg",
	ft = "norg",
	opts = {
		load = {
			["core.defaults"] = {},
			["core.keybinds"] = {
				config = {
					default_keybinds = true,
					hook = function(keybinds)
						keybinds.remap(
							"norg",
							"n",
							"<CR>",
							"<cmd>Neorg keybind norg core.norg.esupports.hop.hop-link<CR>"
						)
					end,
				},
			},
			["core.export"] = {},
			["core.export.markdown"] = {},
			["core.presenter"] = {
				config = {
					zen_mode = "truezen",
				},
			},
			["core.looking-glass"] = {},
			["core.norg.journal"] = {
				config = {
					workspace = "gtd",
				},
			},
			["core.norg.dirman"] = {
				config = {
					workspaces = {
						work = "~/norg/work",
						home = "~/norg/home",
						note = "~/norg/note",
						gtd = "~/norg/gtd",
					},
					default_workspace = "note",
					-- open_last_workspace = "default",
				},
			},
			["core.norg.manoeuvre"] = {},
			["core.norg.concealer"] = {
				config = {
					-- icon_preset = 'varied',
					icons = {
						todo = {
							enabled = true,

							done = {
								enabled = true,
								icon = "",
								query = "(todo_item_done) @icon",
							},

							pending = {
								enabled = true,
								icon = "",
								query = "(todo_item_pending) @icon",
							},

							undone = {
								enabled = true,
								icon = "",
								query = "(todo_item_undone) @icon",
							},

							uncertain = {
								enabled = true,
								icon = "",
								query = "(todo_item_uncertain) @icon",
							},

							on_hold = {
								enabled = true,
								icon = "",
								query = "(todo_item_on_hold) @icon",
							},

							cancelled = {
								enabled = true,
								icon = "",
								query = "(todo_item_cancelled) @icon",
							},

							recurring = {
								enabled = true,
								icon = "↺",
								query = "(todo_item_recurring) @icon",
							},

							urgent = {
								enabled = true,
								icon = "⚠",
								query = "(todo_item_urgent) @icon",
							},
						},
						list = {
							enabled = true,
							level_1 = {
								enabled = true,
								icon = "",
								query = "(unordered_list1_prefix) @icon",
							},

							level_2 = {
								enabled = true,
								icon = " •",
								query = "(unordered_list2_prefix) @icon",
							},

							level_3 = {
								enabled = true,
								icon = "  •",
								query = "(unordered_list3_prefix) @icon",
							},

							level_4 = {
								enabled = true,
								icon = "   •",
								query = "(unordered_list4_prefix) @icon",
							},

							level_5 = {
								enabled = true,
								icon = "    •",
								query = "(unordered_list5_prefix) @icon",
							},

							level_6 = {
								enabled = true,
								icon = "     •",
								query = "(unordered_list6_prefix) @icon",
							},
						},
						heading = {
							enabled = true,

							level_1 = {
								icon = "",
							},

							level_2 = {
								icon = " ✿",
							},

							level_3 = {
								icon = "  ",
							},

							level_4 = {
								icon = "   ○",
							},

							level_5 = {
								icon = "    ▶",
							},

							level_6 = {
								icon = "     ⤷",
							},
						},

						footnote = {
							single = {
								icon = "",
							},
							multi_prefix = {
								icon = " ",
							},
							multi_suffix = {
								icon = " ",
							},
						},
						delimiter = {
							weak = {
								icon = "⬸",
							},
							strong = {
								icon = "↢",
							},
						},
					},
				},
			},
			["core.norg.qol.toc"] = {},
			["core.norg.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.integrations.nvim-cmp"] = {},
		},
	},
}

-- Get extra JSON schemas
local json_conf = {
	"b0o/SchemaStore.nvim",
	event = { "BufRead *.json" },
}

local surround_conf = {
	"tpope/vim-surround",
	event = { "BufRead", "BufNewFile" },
}

local table_conf = {
	"dhruvasagar/vim-table-mode",
	ft = "markdown",
	config = function()
		vim.g.table_mode_corner = "|"
	end,
}

return {
	ts_conf,
	snip_conf,
	cmp_conf,
	pair_conf,
	comment_conf,
	dap_conf,
	rust_conf,
	crate_conf,
	neorg_conf,
	json_conf,
	surround_conf,
	table_conf,
}
