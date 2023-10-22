return {
    "rcarriga/nvim-notify",
    opts = {
        timeout = 3000,
        top_down = false,
    },
    config = function(_, opts)
        require("notify").setup(opts)
        vim.notify = require("notify")
    end,
}
