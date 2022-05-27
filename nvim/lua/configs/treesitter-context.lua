local M = {}

function M.config()
  local ctx = _G.safe_require('treesitter-context')
  if not ctx then
    return
  end
  ctx.setup {
    enable = false,
    max_lines = 1,
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
