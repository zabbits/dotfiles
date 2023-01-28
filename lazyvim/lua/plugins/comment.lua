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
  local comment = require("Comment")
  comment.setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

return M
