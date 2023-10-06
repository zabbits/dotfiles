return {
    "akinsho/bufferline.nvim",
    event = { "BufRead", "BufNewFile" },
    keys = {
        { "H", "<cmd>BufferLineCyclePrev<cr>", desc = "BufPrev" },
        { "L", "<cmd>BufferLineCycleNext<cr>", desc = "BufNext" },
        { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "BufNext" },
    },
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
}
