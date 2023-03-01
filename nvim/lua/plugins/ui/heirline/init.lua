return {
	"rebelot/heirline.nvim",
	event = { "BufAdd", "BufReadPre", "BufRead", "BufNewFile" },
	config = function()
		local os_sep = package.config:sub(1, 1)
		local api = vim.api
		local fn = vim.fn
		local bo = vim.bo
		local status = require("core.status")

		local core_icons = require("core.icons")
		local conditions = require("heirline.conditions")
		local heirline_utils = require("heirline.utils")
		local devicons = require("nvim-web-devicons")
		local util = require("plugins.ui.heirline.util")
		local icons = util.icons
		local mode = util.mode
		local hydra = require("hydra.statusline")

		local theme = require("plugins.ui.heirline.themes")
		local hl = theme.highlight
		local colors = theme.colors
		local lsp_colors = theme.lsp_colors

		vim.o.showmode = false

		local hydras_to_ignore = {
			Barbar = true,
			-- Folds = true
		}

		-- Flexible components priorities
		local priority = {
			CurrentPath = 60,
			Git = 40,
			WorkDir = 25,
			Lsp = 10,
		}

		local Align, Space, Null, ReadOnly, VerticalBar
		do
			Null = { provider = "" }

			Align = { provider = "%=" }

			Space = setmetatable({ provider = " " }, {
				__call = function(_, n)
					return { provider = string.rep(" ", n) }
				end,
			})

			ReadOnly = {
				condition = function()
					return not bo.modifiable or bo.readonly
				end,
				provider = icons.padlock,
				hl = hl.ReadOnly,
			}

			VerticalBar = {
				provider = icons.powerline.vertical_bar,
			}
		end

		local LeftCap = {
			provider = "▌",
			hl = hl.Mode.normal,
		}

		local Indicator
		do
			local HydraName = {
				condition = function()
					return hydra.is_active() and hydra.get_name() and not hydras_to_ignore[hydra.get_name()]
				end,
				heirline_utils.surround(
					{ icons.powerline.left_rounded, icons.powerline.right_rounded },
					function()
						return theme.hydra[hydra.get_color()]
					end, -- color
					{
						{
							fallthrough = false,
							ReadOnly,
							{ provider = icons.circle },
						},
						Space,
						{
							provider = function()
								return hydra.get_name() or "HYDRA"
							end,
						},
						hl = { fg = hl.StatusLine.bg, force = true },
					}
				),
			}

			local VimMode
			do
				local NormalModeIndicator = {
					Space,
					{
						fallthrough = false,
						ReadOnly,
						{
							provider = icons.circle,
							hl = function()
								if bo.modified then
									-- return { fg = hl.Mode.insert.bg }
									return { fg = colors.blue2 }
								else
									return hl.Mode.normal
								end
							end,
						},
					},
					Space,
				}

				local ActiveModeIndicator = {
					condition = function(self)
						return self.mode ~= "normal"
					end,
					hl = { bg = hl.StatusLine.bg },
					heirline_utils.surround(
						{ icons.powerline.left_rounded, icons.powerline.right_rounded },
						function(self) -- color
							return hl.Mode[self.mode].bg
						end,
						{
							{
								fallthrough = false,
								ReadOnly,
								{ provider = icons.circle },
							},
							Space,
							{
								provider = function(self)
									return util.mode_lable[self.mode]
								end,
							},
							hl = function(self)
								return hl.Mode[self.mode]
							end,
						}
					),
				}

				VimMode = {
					init = function(self)
						self.mode = mode[fn.mode(1)] -- :h mode()
					end,
					condition = function()
						return bo.buftype == ""
					end,
					{
						fallthrough = false,
						ActiveModeIndicator,
						NormalModeIndicator,
					},
				}
			end

			Indicator = {
				fallthrough = false,
				HydraName,
				VimMode,
			}
		end

		local HydraHint = {
			condition = function()
				return hydra.get_hint()
			end,
			provider = hydra.get_hint,
		}

		local FileNameBlock, CurrentPath, FileName
		do
			local FileIcon = {
				condition = function()
					return not ReadOnly.condition()
				end,
				init = function(self)
					local filename = self.filename
					local extension = fn.fnamemodify(filename, ":e")
					self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
				end,
				provider = function(self)
					if self.icon then
						return self.icon .. " "
					end
				end,
				hl = function(self)
					return { fg = self.icon_color, italic = false, bold = false }
				end,
			}

			local WorkDir = {
				condition = function(self)
					if bo.buftype == "" then
						return self.pwd
					end
				end,
				hl = hl.WorkDir,
				flexible = priority.WorkDir,
				{
					provider = function(self)
						return self.pwd
					end,
				},
				{
					provider = function(self)
						return fn.pathshorten(self.pwd)
					end,
				},
				Null,
			}

			CurrentPath = {
				condition = function(self)
					if bo.buftype == "" then
						return self.current_path
					end
				end,
				hl = hl.CurrentPath,
				flexible = priority.CurrentPath,
				{
					provider = function(self)
						return self.current_path
					end,
				},
				{
					provider = function(self)
						return fn.pathshorten(self.current_path, 2)
					end,
				},
				{ provider = "" },
			}

			FileName = {
				provider = function(self)
					return self.filename
				end,
				hl = hl.FileName,
			}

			FileNameBlock = {
				{
					on_click = {
						callback = function()
							vim.cmd("Neotree action=show source=filesystem reveal=true")
						end,
						name = "heirline_file_click",
					},
					FileIcon,
					WorkDir,
					CurrentPath,
					FileName,
				},
				-- This means that the statusline is cut here when there's not enough space.
				{ provider = "%<" },
			}
		end

		--------------------------------------------------------------------------------

		local FileInfo = {
			{
				provider = function()
					return vim.bo.filetype
				end,
			},
			Space,
			{
				condition = function()
					return vim.bo.fileencoding ~= "" and vim.bo.fileencoding ~= nil
				end,
				provider = function()
					return vim.bo.fileencoding:lower()
				end,
			},
		}

		local Treesitter = {
			condition = status.treesitter.exist,
			hl = {
				bold = true,
				fg = colors.purple,
			},
			provider = function()
				return status.treesitter.icon .. " TS"
			end,
			on_click = {
				callback = function()
					util.ts.buf_module_info()
				end,
				name = "heirline_ts_click",
			},
			Space,
		}

		local Diagnostics = {
			condition = conditions.has_diagnostics,
			on_click = {
				callback = function()
					require("trouble").toggle({ mode = "document_diagnostics" })
				end,
				name = "heirline_diagnostics_click",
			},
			static = {
				error_icon = core_icons.lsp.error,
				warn_icon = core_icons.lsp.warn,
				info_icon = core_icons.lsp.info,
				hint_icon = core_icons.lsp.hint,
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			{
				provider = function(self)
					return self.errors > 0 and table.concat({ self.error_icon, " ", self.errors, " " })
				end,
				hl = hl.Diagnostic.error,
			},
			{
				provider = function(self)
					return self.warnings > 0 and table.concat({ self.warn_icon, " ", self.warnings, " " })
				end,
				hl = hl.Diagnostic.warn,
			},
			{
				provider = function(self)
					return self.info > 0 and table.concat({ self.info_icon, " ", self.info, " " })
				end,
				hl = hl.Diagnostic.info,
			},
			{
				provider = function(self)
					return self.hints > 0 and table.concat({ self.hint_icon, " ", self.hints, " " })
				end,
				hl = hl.Diagnostic.hint,
			},
		}

		local Lsp
		do
			local LspIndicator = {
				provider = core_icons.lsp.base .. " LSP",
				hl = hl.LspIndicator,
				on_click = {
					callback = function()
						vim.cmd("LspInfo")
					end,
					name = "heirline_lsp_click",
				},
			}

			Lsp = {
				condition = conditions.lsp_attached,
				hl = {
					bold = true,
				},
				LspIndicator,
				Space,
				-- Diagnostics,
			}
		end

		local Git
		do
			local GitBranch = {
				condition = conditions.is_git_repo,
				init = function(self)
					self.git_status = vim.b.gitsigns_status_dict
				end,
				hl = hl.Git.branch,
				provider = function(self)
					return table.concat({ " ", core_icons.git.base, " ", self.git_status.head })
				end,
			}

			local function git_mode_provider(git_mode)
				return function()
					return git_mode.count() > 0
						and table.concat({ git_mode.icon, " ", tostring(git_mode.count()), " " })
				end
			end

			local GitStatus = {
				condition = function(self)
					if conditions.is_git_repo() then
						self.git_status = vim.b.gitsigns_status_dict
						return self.git_status.added ~= 0
							or self.git_status.removed ~= 0
							or self.git_status.changed ~= 0
					end
				end,
				{
					provider = git_mode_provider(status.git.added),
					hl = hl.Git.added,
				},
				{
					provider = git_mode_provider(status.git.removed),
					hl = hl.Git.removed,
				},
				{
					provider = git_mode_provider(status.git.changed),
					hl = hl.Git.changed,
				},
			}

			Git = {
				on_click = {
					callback = function()
						vim.cmd("TermExec cmd='gitui'")
					end,
					name = "heirline_git_click",
				},
				GitBranch,
				Space,
				GitStatus,
			}
		end

		local SearchResults = {
			condition = function(self)
				local lines = api.nvim_buf_line_count(0)
				if lines > 50000 then
					return
				end

				local query = fn.getreg("/")
				if query == "" then
					return
				end

				if query:find("@") then
					return
				end

				local search_count = fn.searchcount({ recompute = 1, maxcount = -1 })
				local active = false
				if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
					active = true
				end
				if not active then
					return
				end

				query = query:gsub([[^\V]], "")
				query = query:gsub([[\<]], ""):gsub([[\>]], "")

				self.query = query
				self.count = search_count
				return true
			end,
			{
				provider = function(self)
					return table.concat({
						-- ' ', self.query, ' ', self.count.current, '/', self.count.total, ' '
						" ",
						self.count.current,
						"/",
						self.count.total,
						" ",
					})
				end,
				hl = hl.SearchResults,
			},
		}

		local Ruler = {
			provider = "%2(%l/%L%) %P",
			hl = {
				fg = colors.black,
				bold = true,
			},
		}

		local ScrollPercentage = {
			condition = function()
				return conditions.width_percent_below(4, 0.035)
			end,
			-- %P  : percentage through file of displayed window
			provider = " %2(%P%) ",
			hl = hl.StatusLine,
		}

		--------------------------------------------------------------------------------

		local MicroRecord = {
			condition = require("noice").api.status.mode.has,
			{
				provider = icons.powerline.left_rounded,
				hl = {
					fg = colors.black,
					bg = colors.green,
				},
			},
			{
				provider = require("noice").api.status.mode.get,
				hl = {
					fg = colors.green,
					bg = colors.black,
				},
			},
			{
				provider = icons.powerline.right_rounded,
				hl = {
					fg = colors.black,
					bg = colors.green,
				},
			},
		}

		local SpecialBuf = {
			provider = function()
				return util.get_special_buf_text(vim.bo.filetype)
			end,
		}

		local StatusLines = {
			init = function(self)
				local pwd = fn.getcwd(0) -- Present working directory.
				local current_path = api.nvim_buf_get_name(0)
				local filename

				if current_path == "" then
					pwd = fn.fnamemodify(pwd, ":~")
					current_path = nil
					filename = " [No Name]"
				elseif current_path:find(pwd, 1, true) then
					filename = fn.fnamemodify(current_path, ":t")
					current_path = fn.fnamemodify(current_path, ":~:.:h")
					pwd = fn.fnamemodify(pwd, ":~") .. os_sep
					if current_path == "." then
						current_path = nil
					else
						current_path = current_path .. os_sep
					end
				else
					pwd = nil
					filename = fn.fnamemodify(current_path, ":t")
					current_path = fn.fnamemodify(current_path, ":~:.:h") .. os_sep
				end

				self.pwd = pwd
				self.current_path = current_path -- The opened file path relevant to pwd.
				self.filename = filename
			end,
			hl = hl.StatusLine,
			{
				condition = function()
					return not util.is_special_buf(vim.bo.filetype)
				end,
				LeftCap,
				Indicator,
				Git,
				{
					fallthrough = false,
					{
						FileNameBlock,
					},
				},
				Align,
				MicroRecord,
				SearchResults,
				{
          condition = function ()
            return conditions.lsp_attached() or status.treesitter.exist()
          end,
					hl = {
						bg = "#2d361c",
					},
					Space,
					Lsp,
					Treesitter,
				},
				{
					Space,
					hl = {
						bg = "#4d772a",
						fg = "#00008b",
						bold = true,
						italic = true,
					},
					FileInfo,
					Space,
				},
				{
					Space,
					hl = {
						bg = "#73b839",
						italic = true,
					},
					Ruler,
				},
			},
			{
				condition = function()
					return util.is_special_buf(vim.bo.filetype)
				end,
				hl = {
					bold = true,
					italic = true,
				},
				Align,
				{
					SpecialBuf,
					hl = {
						fg = colors.green,
					},
				},
				Align,
			},
		}

		--------------------------------------------------------------------------------

		require("heirline").setup({
			statusline = StatusLines,
		})
	end,
}
