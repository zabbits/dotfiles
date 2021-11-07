local M = {}

function M.setup()
  local o = vim.o
  local opt = vim.opt
  local g = vim.g
  local cmd = vim.cmd

  g.mapleader = ' '
  o.termguicolors = true
  -- 缩进及tab, TODO 根据文件类型设置
  o.shiftround  = true
  o.autoindent = true
  o.smartcase = true
  o.smarttab  = true
  o.smartindent = true
  o.expandtab = true
  o.shiftwidth = 4
  o.tabstop = 4
  -- 多文件跳转取消提示
  o.hidden = true
  -- 使用鼠标
  o.mouse = 'a'
  -- 行号
  o.number = true
  o.relativenumber = true
  o.numberwidth = 2
  -- change leader to space
  o.history = 200
  -- don't auto commenting new lines
  cmd[[
    autocmd BufWinEnter,BufRead,BufNewFile * set fo-=c fo-=r fo-=o fo-=2 fo-=a
  ]]

  -- 2 space for selected filetypes
  cmd[[
    autocmd FileType markdown,xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
  ]]

end

return M
