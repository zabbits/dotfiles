local ok, config = pcall(require, 'nvim-autopairs')
if not ok then
    return
end

config.setup{}

