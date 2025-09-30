-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false
vim.g.snacks_animate = false
vim.g.trouble_lualine = false

local options = {
    -- indent
    smartindent = true,
    autoindent = true,
    expandtab = true,
    shiftwidth = 4,
    softtabstop = 4,
    tabstop = 4,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
