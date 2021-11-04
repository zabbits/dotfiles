local ok, configs = pcall(require, 'nvim-web-devicons')
if not ok then
    return
end

configs.setup {
    default = true,
}






