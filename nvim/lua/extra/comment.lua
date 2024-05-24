return {
    "folke/ts-comments.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {},
    enabled = vim.fn.has("nvim-0.10.0") == 1,
}
