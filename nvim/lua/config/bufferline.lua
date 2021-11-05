local M = {}

function M.setup()
  local ok, bufferline = pcall(require, 'bufferline')
  if not ok then
    return
  end

  bufferline.setup({
      options = {
          numbers = "ordinal",
          diagnostics = false,
          show_tab_indicators = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left"
            }
          },
          show_buffer_close_icons = true,
          show_close_icon = true,
      }
  })



end

return M
