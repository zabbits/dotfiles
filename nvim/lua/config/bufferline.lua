local M = {}

M.setup = function()
  require('bufferline').setup {
    options = {
      offsets = {
        {
          filetype = "NvimTree", 
          text = "File Explorer", 
          text_align = "center",
        },
      },
    }
  }
end

return M
