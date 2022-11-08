local M = {}
local icons = require("core.icons")

function M.lsp_name(msg)
  msg = msg or "Inactive"
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return "Inactive"
    end
    return msg
  end
  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  local formatters = require "core.utils"
  local supported_formatters = formatters.list_registered_formatters(buf_ft)
  vim.list_extend(buf_client_names, supported_formatters)

  local linters = require "core.utils"
  local supported_linters = linters.list_registered_linters(buf_ft)
  vim.list_extend(buf_client_names, supported_linters)

  return table.concat(buf_client_names, ", ")
end

function M.treesitter_status()
  local b = vim.api.nvim_get_current_buf()
  if vim.treesitter.highlighter.active[b] and next(vim.treesitter.highlighter.active[b]) then
    return ' ' .. icons.treesitter.base .. ' '
  end
  return ""
end

function M.progress_bar()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local function get_diagnostics_count(severity, bufnr)
  bufnr = bufnr or 0
  return vim.tbl_count(vim.diagnostic.get(bufnr, severity and { severity = severity }))
end


M.diagnostic = {
  error = {
    count = function(bufnr)
      return get_diagnostics_count(vim.diagnostic.severity.ERROR, bufnr)
    end,
    icon = icons.lsp.error,
  },
  warn = {
    count = function(bufnr)
      return get_diagnostics_count(vim.diagnostic.severity.WARN, bufnr)
    end,
    icon = icons.lsp.warn,
  },
  hint = {
    count = function(bufnr)
      return get_diagnostics_count(vim.diagnostic.severity.HINT, bufnr)
    end,
    icon = icons.lsp.hint,
  },
  info = {
    count = function(bufnr)
      return get_diagnostics_count(vim.diagnostic.severity.INFO, bufnr)
    end,
    icon = icons.lsp.info,
  },
}

return M
