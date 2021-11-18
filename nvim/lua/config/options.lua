local M = {}

function M.setup()
  local o = vim.o
  local opt = vim.opt
  local g = vim.g
  local cmd = vim.cmd

  --Remap space as leader key
  g.mapleader = ' '
  g.maplocalleader = ' '
  -- Set completeopt to have a better completion experience
  o.completeopt = 'menuone,noselect'

  o.termguicolors = true
  -- 缩进及tab, TODO 根据文件类型设置
  o.breakindent = true
  o.shiftround  = true
  o.autoindent = true
  o.smartcase = true
  o.smarttab  = true
  o.smartindent = true
  o.expandtab = true
  o.shiftwidth = 4
  o.tabstop = 4
  --Case insensitive searching UNLESS /C or capital in search
  o.ignorecase = true
  o.smartcase = true
  -- 多文件跳转取消提示
  o.hidden = true
  -- 使用鼠标
  o.mouse = 'a'

  -- 行号
  o.number = true
  o.relativenumber = true
  o.numberwidth = 2

  --Save undo history
  opt.undofile = true
  o.history = 200

  -- 2 space for selected filetypes
  cmd [[
    autocmd FileType markdown,xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
  ]]

  -- Highlight on yank
  cmd [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
  ]]

  -- don't auto commenting new lines
  cmd [[
      autocmd Filetype * set fo-=cro
  ]]

end

return M
