local M = {}

function M.config()
  local status_ok, comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

  comment.setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
  })

  local function map(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
  end

  -- Linewise toggle current line using C-/
  map('i', '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>')
  map('n', '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>')
  map('x', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
end

return M
