local options = {
  fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
  list = false,
  -- laststatus = 3,
  completeopt = { "menuone", "noselect", "menuone" }, -- Options for insert mode completion
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
