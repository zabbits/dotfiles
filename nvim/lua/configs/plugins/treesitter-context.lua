local M = {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = false,
  event = { 'BufRead', 'BufNewFile' },
  dependencies = { "nvim-treesitter" },
}

function M.config()
  local ctx = safe_require('treesitter-context')
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
