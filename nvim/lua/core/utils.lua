local M = {}

local g = vim.g

--- Check if packer is installed and loadable, if not then install it and make sure it loads
function M.initialize_packer()
  local stdpath = vim.fn.stdpath 
  -- try loading packer
  local packer_avail, _ = pcall(require, "packer")
  -- if packer isn't availble, reinstall it
  if not packer_avail then
    -- set the location to install packer
    local packer_path = stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    -- delete the old packer install if one exists
    vim.fn.delete(packer_path, "rf")
    -- clone packer
    vim.fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      packer_path,
    }
    print({ { "Initializing Packer...\n\n" } })
    -- add packer and try loading it
    vim.cmd.packadd "packer.nvim"
    packer_avail, _ = pcall(require, "packer")
    -- if packer didn't load, print error
    if not packer_avail then vim.api.nvim_err_writeln("Failed to load packer at:" .. packer_path) end
  end
  -- if packer is available, check if there is a compiled packer file
  if packer_avail then
    -- try to load the packer compiled file

    local run_me, _ = loadfile(stdpath("config") .. "/lua/packer_compiled.lua")
    -- if the file loads, run the compiled function
    if run_me then
      run_me()
      -- if there is no compiled file, prompt the user to run :PackerSync
    else
      print({ { "Please run " }, { ":PackerSync", "Title" } })
    end
  end
end

function M.disabled_builtins()
  g.loaded_2html_plugin = false
  g.loaded_getscript = false
  g.loaded_getscriptPlugin = false
  g.loaded_gzip = false
  g.loaded_logipat = false
  g.loaded_netrwFileHandlers = false
  g.loaded_netrwPlugin = false
  g.loaded_netrwSettngs = false
  g.loaded_remote_plugins = false
  g.loaded_tar = false
  g.loaded_tarPlugin = false
  g.loaded_zip = false
  g.loaded_zipPlugin = false
  g.loaded_vimball = false
  g.loaded_vimballPlugin = false
  g.zipPlugin = false
end

function M.list_registered_providers_names(filetype)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

function M.list_registered_formatters(filetype)
  local null_ls_methods = require "null-ls.methods"
  local formatter_method = null_ls_methods.internal["FORMATTING"]
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[formatter_method] or {}
end

function M.list_registered_linters(filetype)
  local null_ls_methods = require "null-ls.methods"
  local formatter_method = null_ls_methods.internal["DIAGNOSTICS"]
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[formatter_method] or {}
end

function M.is_available(plugin)
  return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

function M.safe_require(modname)
  local present, mod = pcall(require, modname)
  if present then
    return mod
  end
  return nil
end

_G.safe_require = M.safe_require

_G.packer_load = function (plugin_name)
  require("packer").loader(plugin_name)
end

_G.is_plugin_load = function (plugin_name)
    return packer_plugins[plugin_name].loaded
end

return M
