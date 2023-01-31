local M = {
  git = {
    base = '',
    added = "",
    modified = "",
    deleted = "",
    renamed = "",
    untracked = "",
    ignored = "◌",
    unstaged = "",
    staged = "",
    conflict = "",
  },
  lsp = {
    error = '',
    warn = '',
    hint = '',
    info = '',
  },
  os = {
    linux = '',
    darwin = '',
    windows = '',
  },
  treesitter = {
    base = '',
  },
}

return M
