local ok, config = pcall(require, 'onedark')
if not ok then
    return
end

config.setup()

