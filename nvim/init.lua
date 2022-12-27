local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('core.options')
local utils = require "core.utils"
utils.disabled_builtins()
require("core.mappings")
require('configs.lazy')
require("core.plugins")
require("core.autocmds")
require("core.usercommands")

-- local impatient_ok, impatient = pcall(require, "impatient")
-- if impatient_ok then
--   impatient.enable_profile()
-- end
--
-- local utils = require "core.utils"
--
--
-- utils.initialize_packer()
--
-- local sources = {
--   "core.options",
--   "core.plugins",
--   "core.autocmds",
--   "core.usercommands",
--   "core.mappings",
-- }
--
-- for _, cfg in ipairs(sources) do 
-- 	require(cfg)
-- end

