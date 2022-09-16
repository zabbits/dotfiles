local M = {}

function M.config()
  local ctx = _G.safe_require('treesitter-context')
  if not ctx then
    return
  end
  ctx.setup {
    enable = true,
    max_lines = 1,
    patterns = {
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        'if',
        'switch',
        'case',
      },
    },
  }

end

return M
