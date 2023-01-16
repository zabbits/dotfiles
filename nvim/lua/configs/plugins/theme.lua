local M = {
  'tiagovla/tokyodark.nvim',
  lazy = false,
  dependencies = {
  },
}

function M.config()
  vim.cmd.colorscheme("tokyodark")
end

return M
