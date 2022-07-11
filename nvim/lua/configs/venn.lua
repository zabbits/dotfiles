local M = {}

function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd [[setlocal ve=all]]
  else
    vim.cmd [[setlocal ve=]]
    vim.b.venn_enabled = nil

  end
end

function M.config()
  local venn = _G.safe_require("venn")
  if not venn then
    return
  end
  -- toggle keymappings for venn using <leader>v
  vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true })
end

return M
