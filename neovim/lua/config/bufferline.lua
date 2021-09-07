local ok, configs = pcall(require, 'bufferline')
if not ok then
    return
end

configs.setup{
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        }
    }
}
