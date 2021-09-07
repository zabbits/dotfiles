local opt = vim.opt
local g = vim.g
opt.termguicolors = true

-- 通用配置, TODO 提取到配置文件
-- 缩进及tab, TODO 根据文件类型设置
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
-- 多文件跳转取消提示
opt.hidden = true
-- 使用鼠标
opt.mouse = 'a'
-- 行号
opt.number = true
opt.numberwidth = 2

g.mapleader = ' '
