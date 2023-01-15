local M = {
  'tiagovla/tokyodark.nvim',
  lazy = false,
  dependencies = {
    'noorwachid/nvim-nightsky',
  },
}

function M.config()
  vim.cmd.colorscheme("tokyodark")
  -- vim.cmd.colorscheme("nightsky")
end

return M
