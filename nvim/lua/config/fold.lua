local ok, fold = pcall(require, 'pretty-fold')
if not ok then
  return
end

fold.setup({})
require('pretty-fold.preview').setup()
