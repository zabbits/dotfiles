local M = {
  'jedrzejboczar/possession.nvim',
  -- event = { 'BufRead', 'BufNewFile' },
  dependencies = { 'telescope.nvim' },
}

function M.config()
  local possession = _G.safe_require('possession')
  if not possession then
    return
  end
  possession.setup({
    plugins = {
      close_windows = false,
      delete_hidden_buffers = false,
      nvim_tree = false,
      tabby = false,
    }
  })
end

return M
