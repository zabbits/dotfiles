local ok, lualine = pcall(require, 'lualine')
if not ok then
    return
end
local onedark, _ = pcall(require, 'onedark')
local opt = {    
    component_separators = {'', ''},
    section_separators = {'', ''}
}
if onedark then
    opt['theme'] = 'onedark'
end

lualine.setup {
  options = opt
}
