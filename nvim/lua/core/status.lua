local M = {}
local icons = require("core.icons")
local b = vim.b

-- ========== treesitter =========
M.treesitter = {
  exist = function()
    local buf = vim.api.nvim_get_current_buf()
    return vim.treesitter.highlighter.active[buf] and next(vim.treesitter.highlighter.active[buf])
  end,
  icon = icons.treesitter.base,
}


-- ========== lsp =========
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

  return table.concat(buf_client_names, ", ")
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

-- ========== git =========
-- Common function used by the git providers
local function git_diff(type)
  local gsd = b.gitsigns_status_dict

  if gsd and gsd[type] then
    return gsd[type]
  end

  return 0
end

M.git = {
  exist = b.gitsigns_head or b.gitsigns_status_dict,
  added = {
    count = function()
      return git_diff("added")
    end,
    icon = icons.git.added,
  },
  removed = {
    count = function()
      return git_diff("removed")
    end,
    icon = icons.git.deleted
  },
  changed = {
    count = function()
      return git_diff("changed")
    end,
    icon = icons.git.modified,
  }
}

return M
