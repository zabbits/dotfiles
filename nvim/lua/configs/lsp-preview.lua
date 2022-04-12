local M = {}

function M.config()
  local present, preview = pcall(require, 'goto-preview')
  if not present then
    return
  end

  -- keymaps defined in mappings file
  preview.setup({})
end

return M
