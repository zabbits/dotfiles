local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

local utils = require "core.utils"

utils.disabled_builtins()

utils.initialize_packer()

local sources = {
  "core.options",
  "core.plugins",
  "core.autocmds",
  "core.usercommands",
  "core.mappings",
}

for _, cfg in ipairs(sources) do 
	require(cfg)
end

