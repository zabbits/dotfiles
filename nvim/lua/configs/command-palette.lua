local M = {}

function M.config()
  local cp = _G.safe_require("command-palette")
  local telescope = require("telescope")
  if not cp then
    return
  end
  local opts = {
    nodes = {
      {
        label = "DiffView",
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
    },
  }

  cp.setup(opts)
  telescope.load_extension("command_palette")
end

return M
