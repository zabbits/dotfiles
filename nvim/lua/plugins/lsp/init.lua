local lsp_conf = {
	"neovim/nvim-lspconfig",
	event = { "BufRead", "BufNewFile" },
	dependencies = {
		"mason.nvim",
		"mason-lspconfig.nvim",
		"folke/neodev.nvim",
		"lspkind.nvim",
		"trouble.nvim",
		"lspsaga.nvim",
		"lsp_lines.nvim",
		-- "fidget.nvim",
		"vim-illuminate",
		"null-ls.nvim",
		"incline.nvim",
		"typescript.nvim",
	},
	config = function()
		require("neodev").setup({})

		local mason_lsp = require("mason-lspconfig")
		local lspconfig = require("lspconfig")
		local handlers = require("plugins.lsp.handlers")
		handlers.setup()

		local servers = mason_lsp.get_installed_servers() or {}
		for _, server_name in ipairs(servers) do
			local opts = {
				on_attach = handlers.on_attach,
				capabilities = handlers.capabilities,
			}

			local present, av_overrides = pcall(require, "plugins.lsp.server-settings." .. server_name)
			if present then
				opts = vim.tbl_deep_extend("force", av_overrides, opts)
			end
			-- set servers manully
			local independent_servers = {
				"rust_analyzer",
				"typescript",
			}
			if not vim.tbl_contains(independent_servers, server_name) then
				lspconfig[server_name].setup(opts)
			end
		end

		-- 是否使用volar
		local configs = require("core.configs")
		if configs.lsp.volar then
			local defaultOpts = {
				on_attach = handlers.on_attach,
				capabilities = handlers.capabilities,
			}
			require("plugins.lsp.vue-volar")
			lspconfig.volar_api.setup(defaultOpts)
			lspconfig.volar_doc.setup(defaultOpts)
			lspconfig.volar_html.setup(defaultOpts)
		end
	end,
}

local lspkind_conf = {
	"onsails/lspkind.nvim",
	config = function()
		require("lspkind").init({})
	end,
}

local lspsaga_conf = {
	"glepnir/lspsaga.nvim",
	opts = {
		ui = {
			code_action = "",
		},
		lightbulb = {
			enable = true,
			enable_in_insert = true,
			sign = false,
			sign_priority = 40,
			virtual_text = true,
		},
		symbol_in_winbar = {
			enable = true,
			separator = "  ",
			hide_keyword = true,
			show_file = true,
			folder_level = 2,
			respect_root = false,
			color_mode = true,
		},
		diagnostic = {
			on_insert = false,
		},
		beacon = {
			enable = false,
		},
	},
}

local trouble_conf = {
	"folke/trouble.nvim",
	opts = function()
		local status = require("core.status")
		return {
			indent_lines = false, -- add an indent guide below the fold icons
			auto_open = false, -- automatically open the list when you have diagnostics
			auto_close = false, -- automatically close the list when you have no diagnostics
			auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
			auto_fold = false, -- automatically fold a file trouble list at creation
			auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
			signs = {
				-- icons / text used for a diagnostic
				error = status.diagnostic.error.icon,
				warning = status.diagnostic.warn.icon,
				hint = status.diagnostic.hint.icon,
				information = status.diagnostic.error.icon,
				other = "",
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		}
	end,
}

local lines_conf = {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	config = function()
		vim.diagnostic.config({ virtual_lines = false })
		require("lsp_lines").setup()
	end,
}

local fidget_conf = {
	"j-hui/fidget.nvim",
	opts = {
		text = {
			done = "",
		},
	},
}

local illuminate_conf = {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			providers = {
				"lsp",
			},
			delay = 200,
			filetypes_denylist = {
				"dirvish",
				"fugitive",
				"lazy",
				"neo-tree",
				"mason",
			},
			under_cursor = true,
		})
	end,
}

local null_ls = {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"mason.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				require("typescript.extensions.null-ls.code-actions"),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					condition = function(utils)
						return utils.has_file({ ".prettierrc.js", ".prettierrc" })
					end,
				}),
			},
		})
		require("mason-null-ls").setup({
			automatic_setup = false,
		})
	end,
}

local incline_conf = {
	"b0o/incline.nvim",
	config = function()
		local function get_diagnostic_label(props)
			local ics = require("core.icons")
			local icons = {
				Error = ics.lsp.error,
				Warn = ics.lsp.warn,
				Hint = ics.lsp.hint,
				Info = ics.lsp.info,
			}
			local label = {}
			for severity, icon in pairs(icons) do
				local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
				if n > 0 then
					table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
				end
			end
			return label
		end

		require("incline").setup({
			debounce_threshold = { falling = 500, rising = 250 },
			render = get_diagnostic_label,
		})
	end,
}

local typescript_conf = {
	"jose-elias-alvarez/typescript.nvim",
	opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
	},
}

local inlay_hints = {
	"lvimuser/lsp-inlayhints.nvim",
	event = "LspAttach",
	branch = "anticonceal",
	opts = {},
	init = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
			callback = function(args)
				if not (args.data and args.data.client_id) then
					return
				end
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				require("lsp-inlayhints").on_attach(client, args.buf)
			end,
		})
	end,
}

return {
	lsp_conf,
	lspkind_conf,
	lspsaga_conf,
	trouble_conf,
	lines_conf,
	-- fidget_conf,
	illuminate_conf,
	null_ls,
	incline_conf,
	typescript_conf,
  -- inlay_hints,
}
