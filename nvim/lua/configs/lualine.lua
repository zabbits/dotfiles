local M = {}

local status = require "core.status"

local function get_hl_by_name(name)
  return string.format("#%06x", vim.api.nvim_get_hl_by_name(name.group, true)[name.prop])
end

local function get_hl_prop(group, prop, default)
  local status_ok, color = pcall(get_hl_by_name, { group = group, prop = prop })
  if status_ok then
    default = color
  end
  return default
end

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  -- local colors = require "default_theme.colors"

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand "%:p:h"
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
    is_filetype_match = function(filetype)
      return function()
        return filetype == vim.o.filetype
      end
    end,
    is_not_in = function(ignored)
      return function()
        return ignored[vim.bo.filetype] == nil
      end
    end,
  }


  local spacer = {
    function()
      return " "
    end,
    padding = { left = 0, right = 0 },
  }


  local function mix(func_a, func_b)
    return function()
      return func_a() and func_b()
    end
  end

  local ignore_filetypes = {
   "NvimTree", "neo-tree", "dashboard", "Outline", "Trouble",
  }
  local function is_not_ignore()
    local ft = vim.bo.filetype
    for _, val in pairs(ignore_filetypes) do
      if ft == val then
        return false
      end
    end
    return true
  end

  local config = {
    options = {
      theme = 'auto',
      -- disabled_filetypes = { "NvimTree", "neo-tree", "dashboard", "Outline" },
      component_separators = "",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_a = { spacer },
      lualine_b = {},
      lualine_c = {
        {
          "branch",
          icon = "",
          -- color = { fg = get_hl_prop("Conditional", "foreground", colors.purple_1), gui = "bold" },
          padding = { left = 2, right = 1 },
          cond = is_not_ignore,
        },
        {
          "filetype",
          cond = conditions.buffer_not_empty,
          padding = { left = 2, right = 1 },
        },
        {
          "diff",
          symbols = { added = " ", modified = "柳", removed = " " },
          cond = mix(conditions.hide_in_width, is_not_ignore),
          padding = { left = 2, right = 1 },
        },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
          cond = is_not_ignore,
          padding = { left = 2, right = 1 },
        },
        {
          function()
            return "%="
          end,
        },
      },
      lualine_x = {
        -- {
        --   status.lsp_progress,
        --   color = { gui = "none" },
        --   padding = { left = 0, right = 1 },
        --   cond = conditions.hide_in_width,
        -- },
        {
          status.lsp_name,
          icon = " ",
          color = { gui = "none" },
          padding = { left = 0, right = 1 },
          cond = mix(conditions.hide_in_width, is_not_ignore),
        },
        {
          status.treesitter_status,
          -- color = { fg = get_hl_prop("GitSignsAdd", "foreground", colors.green) },
          padding = { left = 1, right = 0 },
          cond = mix(conditions.hide_in_width, is_not_ignore),
        },
        {
          "location",
          padding = { left = 1, right = 1 },
          cond = is_not_ignore,
        },
        {
          "progress",
          color = { gui = "none" },
          cond = is_not_ignore,
          padding = { left = 0, right = 0 },
        },
        {
          status.progress_bar,
          padding = { left = 1, right = 2 },
          cond = is_not_ignore,
          -- color = { fg = get_hl_prop("TypeDef", "foreground", colors.yellow) },
        },
      },
      lualine_y = {},
      lualine_z = { spacer },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  lualine.setup(config)
end

return M
