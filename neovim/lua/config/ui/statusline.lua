local ok, lualine = pcall(require, 'lualine')
if not ok then
    return
end
local onedark, _ = pcall(require, 'onedark')
local opt = {
    component_separators = {'', ''},
    -- section_separators = {'', ''}
}
local sections = {}

if onedark then
    opt['theme'] = 'onedark'
end

local egps, gps = pcall(require, 'nvim-gps')

if egps then
    sections = {
        lualine_c = {
            { gps.get_location, condition = gps.is_available },
        },
        lualine_x = {'filename', 'encoding', 'fileformat', 'filetype'}
    }
    gps.setup()
end

lualine.setup {
  options = opt,
  sections = sections,
}
