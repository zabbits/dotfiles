function _G.safe_require(modname)
  local present, mod = pcall(require, modname)
  if present then
    return mod
  end
  return nil
end

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('core.options')
require('configs.lazy')
require("core.mappings")
require("core.autocmds")
require("core.usercommands")
