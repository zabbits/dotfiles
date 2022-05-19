local M = {}

function M.config()
  local utils = require("core.utils")
  local ctx = utils.safe_require('treesitter-context')
  if not ctx then
    return
  end
  ctx.setup {
    enable = true,
    patterns = {
      default = {
        'class',
        'function',
        'method',
        'for', -- These won't appear in the context
        'while',
        'if',
        'switch',
        'case',
      },
    },
  }

end

return M
