return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  opts = {},
  keys = { "gl", desc = "lsp lines" },
  config = function()
    require("lsp_lines").setup()
    vim.keymap.set("", "gl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
  end,
}
