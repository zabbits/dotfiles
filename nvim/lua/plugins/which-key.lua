return {
  "folke/which-key.nvim",
  event = function()
    return {}
  end,
  keys = { "<leader>", "g", "c", "a", "f", "t" },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    opts.defaults["<leader>w"] = nil
    opts.defaults["<leader>q"] = nil
    wk.register(opts.defaults)
    wk.register({
      ["<leader>"] = {
        w = { "<Cmd>w<CR>", "Save" },
        q = { "<Cmd>q<CR>", "Quit" },
      },
    })
  end,
}
