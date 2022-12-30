local M = {
  'sindrets/diffview.nvim',
  cmd = {
    'DiffviewOpen',
    'DiffviewFocusFiles',
    'DiffviewToggleFiles',
    'DiffviewLog',
    'DiffviewFileHistory',
  },
}

function M.config()
  local present, diffview = pcall(require, "diffview")
  if not present then
    return
  end

  diffview.setup()
end

return M
