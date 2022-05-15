local M = {}

function M.config()
  local utils      = require('core.utils')
  local possession = utils.safe_require('possession')
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
