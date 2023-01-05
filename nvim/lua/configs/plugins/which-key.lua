local M = {
  "folke/which-key.nvim",
  keys = {
    { "<leader>", mode = { "n", "v" } },
  }
}

function M.config()
  local which_key = safe_require("which-key")
  if not which_key then
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
  local mappings = {
    n = {
      ["<leader>"] = {
        f = { name = "File" },
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

  init_table("n", "<leader>", "o")
  init_table("n", "<leader>", "g")
  init_table("n", "<leader>", "s")
  init_table("n", "<leader>", "n")
  init_table("n", "<leader>", "h")

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
