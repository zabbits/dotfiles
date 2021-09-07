local ok, config = pcall(require, 'nvim_comment')
if not ok then
    return
end

config.setup({
    create_mappings = false
})

