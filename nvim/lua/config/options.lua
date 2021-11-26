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
  -- tabs and indent
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

  -- improve matchup start time
  g.loaded_matchit = 1

  -- 2 space for selected filetypes
  cmd [[
    autocmd FileType vue,markdown,xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
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
      autocmd BufEnter * set fo-=c fo-=r fo-=o fo-=2 fo-=a
  ]]
  -- cmd [[autocmd VimEnter * set fo-=c fo-=r fo-=o fo-=2 fo-=a]]
end

return M
