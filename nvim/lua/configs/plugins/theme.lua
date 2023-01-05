local M = {
  'tiagovla/tokyodark.nvim',
  lazy = false,
  dependencies = {
    'wuelnerdotexe/vim-enfocado',
  },
}

function M.config()
  vim.cmd.colorscheme("tokyodark")
  -- vim.g.enfocado_style = 'nature' 
  -- vim.cmd.colorscheme("enfocado")
end

return M
