local options = {
  fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
  list = false,
  completeopt = { "menu", "menuone", "noselect" }, -- Options for insert mode completion
  wildmode = "full",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.opt.fillchars:append({
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})
