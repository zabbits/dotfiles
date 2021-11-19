local M = {}

M.setup = function ()
  tsconfig = require('nvim-treesitter.configs')
  tsconfig.setup({
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
end

return M
