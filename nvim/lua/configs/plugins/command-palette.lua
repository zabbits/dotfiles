local M = {
  "in-a-day/command-palette",
  -- "~/github/command-palette",
  keys = "<leader>",
  -- event = { "BufRead", "BufNewFile" },
  dependencies = { "telescope.nvim" },
}

function M.config()
  local cp = _G.safe_require("command-palette")
  local telescope = require("telescope")
  if not cp then
    return
  end
  local opts = {
    nodes = {
      {
        label = "Neorg",
        auto_detect = true,
        children = {
          {
            label = "RunCode",
            cmd = function()
              _G.snr.norg()
            end
          },
          {
            label = "EditCode",
            cmd = "Neorg keybind norg core.looking-glass.magnify-code-block"
          },
        }
      },
      {
        label = "Diffview",
        auto_detect = true,
        children = {
          {
            label = "DiffviewOpen",
            cmd = "DiffviewOpen",
          },
          {
            label = "DiffviewClose",
            cmd = "DiffviewClose",
          },
        },
      },
      {
        label = "Rust",
        auto_detect = true,
        children = {
          {
            label = "RustRunnables",
            cmd = "RustRunnables",
          },
          {
            label = "RustOpenCargo",
            cmd = "RustOpenCargo",
          },
          {
            label = "RustToggleInlayHints",
            cmd = "RustToggleInlayHints",
          },
          {
            label = "RustHoverActions",
            cmd = "RustHoverActions",
          },
        },
      },
      {
        label = "Go",
        auto_detect = true,
      },
      {
        label = "Mason",
        auto_detect = true,
      },
    },
  }

  cp.setup(opts)
  telescope.load_extension("command_palette")
end

return M
