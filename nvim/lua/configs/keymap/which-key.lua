local M = {}

function M.config()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end
  which_key.setup({
    plugins = {
      spelling = { enabled = true },
      presets = { operators = false },
    },
    window = {
      border = "rounded",
      padding = { 2, 2, 2, 2 },
    },
  })

  -- register
  local utils = require "core.utils"
  local mappings = {
    n = {
      ["<leader>"] = {
        f = { name = "File" },
        p = { name = "Packer" },
        l = { name = "LSP" },
        e = { name = "Neotree" }
      },
    },
  }

  local extra_sections = {
    g = "Git",
    l = "LSP",
    s = "Search/Session",
    t = "Terminal",
    h = "Harpoon",
    n = "Neorg",
    o = "Open",
  }

  local function init_table(mode, prefix, idx)
    if not mappings[mode][prefix][idx] then
      mappings[mode][prefix][idx] = { name = extra_sections[idx] }
    end
  end

  if utils.is_available "neo-tree.nvim" then
    init_table("n", "<leader>", "o")
  end

  if utils.is_available "gitsigns.nvim" then
    init_table("n", "<leader>", "g")
  end

  if utils.is_available "telescope.nvim" then
    init_table("n", "<leader>", "s")
  end

  if utils.is_available('neorg') then
    init_table("n", "<leader>", "n")
  end

  if utils.is_available('harpoon') then
    init_table("n", "<leader>", "h")
  end

  for mode, prefixes in pairs(mappings) do
    for prefix, mapping_table in pairs(prefixes) do
      which_key.register(mapping_table, {
        mode = mode,
        prefix = prefix,
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      })
    end
  end
end

return M
