local M = {}

M.setup = function ()
  vim.g.tokyonight_hide_inactive_statusline = true
  vim.g.tokyonight_transparent_sidebar = { "qf", "vista_kind", "terminal", "packer" }
  vim.cmd[[colorscheme tokyonight]]
end

return M
