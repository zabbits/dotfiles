return {
    "rcarriga/nvim-notify",
    init = function()
        vim.notify = require("notify")
    end,
    opts = {
        timeout = 3000,
        top_down = false,
    },
}
