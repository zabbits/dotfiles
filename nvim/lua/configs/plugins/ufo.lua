local M = {
  'kevinhwang91/nvim-ufo',
  event = { 'BufRead', 'BufNewFile' },
  dependencies = { 'kevinhwang91/promise-async' }
}

function M.config()
  local ufo = _G.safe_require("ufo")
  if not ufo then
    return
  end
  ufo.setup()
end

return M
