-- 安装packer
local function checkPacker()
  -- Install packer
  local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  end

  vim.cmd [[
    augroup Packer
      autocmd!
      autocmd BufWritePost init.lua PackerCompile
    augroup end
  ]]
end

checkPacker()
-- 引入基础配置
require('config')
-- 引入插件
require('plugins')

