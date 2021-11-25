local M = {}

M.setup = function ()
  require("toggleterm").setup{
    open_mapping = [[<c-\>]],
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
    direction = 'tab',
  }
end

return M
