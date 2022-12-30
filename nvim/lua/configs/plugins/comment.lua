local M = {
  "numToStr/Comment.nvim",
  -- event = { "BufRead", "BufNewFile" },
  keys = {
    { "gc", mode = { "n", "v" } },
    { "gb", mode = { "n", "v" } },
    { "<C-/>", mode = { "n", "v", "i" } },
  },
}

function M.config()
  local comment = safe_require("Comment")
  if not comment then
    return
  end

  comment.setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
  })

  local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
  end

  -- Linewise toggle current line using C-/
  map('i', '<C-/>', function() require("Comment.api").toggle.linewise.current() end)
  map('n', '<C-/>', function() require("Comment.api").toggle.linewise.current() end)
  map('x', '<C-/>', function() require("Comment.api").toggle.linewise(vim.fn.visualmode()) end)
end

return M
