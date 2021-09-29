-- 安装packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- 引入插件
require('plugins')


-- 引入配置
require('config.norg')
require('config.treesitter')
require('config.compe')
require('config.bufferline')
require('config.devicons')
require('config.statusline')
require('config.indent')
require('config.autopairs')
require('config.nvimtree')
require('config.opt')
require('config.mappings')
require('config.lsp')
require('config.themes')
require('config.comment')
require('config.venn')
require('config.telescope')


