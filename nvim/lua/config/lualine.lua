local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
	"mode",
	fmt = function(str)
		return "[" .. str .. "]"
	end,
}

local filetype = {
	"filetype",
	-- icons_enabled = false,
	-- icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

local lsp = {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    msg = ''
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        if client.name ~= 'null-ls' then
          msg = msg .. client.name .. ' '
        end
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { bg = '#3B4261', gui = 'bold' },
}

-- local session = {
--   function ()
--     local msg = 'Nil'
--     local asl = require('auto-session-library')
--     local ok, name = pcall(asl.current_session_name)
--     if ok then
--       return name
--     end
--     return msg
--   end,
--   icon = '⚐Session:'
-- }

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local themes = {
  normal = {
    a = { bg = '#3b4261', fg = '#7aa2f7' },
    b = { bg = '#3b4261', fg = '#7aa2f7' },
    c = { bg = '#3b4261', fg = '#7aa2f7' },
    x = { bg = '#3b4261', fg = '#7aa2f7' },
    y = { bg = '#3b4261', fg = '#7aa2f7' },
    z = { bg = '#3b4261', fg = '#7aa2f7' },
  }
}

local sections = {
  lualine_a = { mode },
  lualine_b = { branch, diff, diagnostics },
  lualine_c = { lsp },
  lualine_x = { spaces, "encoding", filetype },
  lualine_y = { location },
  lualine_z = { progress },
}

local inactive_sections = {
  lualine_a = { filetype },
  lualine_b = {},
  lualine_c = { "filename" },
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
}


lualine.setup({
	options = {
		icons_enabled = true,
		theme = themes,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		-- disabled_filetypes = { "alpha", "dashboard",  "Outline" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = sections,
	inactive_sections = inactive_sections,
	tabline = {},
	extensions = {},
})
