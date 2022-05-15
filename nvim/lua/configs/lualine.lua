local M = {}

local status = require "core.status"

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  local conditions = {
    is_file_open = function()
      return #(vim.fn.expand('%')) > 0
    end,
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

  local gps = require("core.utils").safe_require("nvim-gps")
  local gps_component = {
    function()
      return ""
    end
  }
  if gps then
    gps_component = {
      gps.get_location,
      cond = function()
        return gps.is_available() and conditions.hide_in_width()
      end
    }
  end

  local function extention_by_filetype(filetype)
    return {
      sections = {
        lualine_a = { 'filetype' }
      },
      inactive_sections = {
        lualine_a = { 'filetype' }
      },
      filetypes = { filetype }
    }
  end

  local ignore_filetypes = {
    "NvimTree", "neo-tree", "dashboard",
    "Outline", "Trouble", "help",
  }
  local disabled_filetypes = {
    "alpha"
  }
  local extensions = {}
  for index, value in ipairs(ignore_filetypes) do
    extensions[index] = extention_by_filetype(value)
  end

  local config = {
    options = {
      theme = 'auto',
      disabled_filetypes = disabled_filetypes,
      component_separators = "",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_a = { spacer },
      lualine_b = { "mode" },
      lualine_c = {
        {
          "branch",
          icon = "",
          padding = { left = 1, right = 1 },
        },
        {
          "filetype",
          cond = conditions.buffer_not_empty,
          padding = { left = 1, right = 1 },
        },
        {
          "diff",
          symbols = { added = " ", modified = " ", removed = " " },
          cond = conditions.hide_in_width,
          padding = { left = 1, right = 1 },
        },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          -- symbols = { error = " ", warn = " ", info = " ", hint = " " },
          always_visible = conditions.is_file_open,
          update_in_insert = true,
          padding = { left = 1, right = 1 },
        },
        gps_component,
        {
          function()
            return "%="
          end,
        },
      },
      lualine_x = {
        {
          status.lsp_name,
          icon = " ",
          padding = { left = 0, right = 1 },
          cond = conditions.hide_in_width,
        },
        {
          status.treesitter_status,
          padding = { left = 1, right = 0 },
          cond = conditions.hide_in_width,
        },
        {
          "location",
          padding = { left = 1, right = 1 },
        },
        {
          "progress",
          padding = { left = 0, right = 0 },
        },
        {
          status.progress_bar,
          padding = { left = 1, right = 2 },
        },
      },
      lualine_y = {},
      lualine_z = {
        spacer,
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
    extensions = extensions,
  }

  lualine.setup(config)
end

return M
