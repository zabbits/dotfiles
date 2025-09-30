return {
    "stevearc/conform.nvim",
    keys = {
        {
            "gq",
            function()
                LazyVim.format({ force = true })
                require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
            end,
            mode = { "n", "v" },
            desc = "Format Injected Langs",
        },
    },
}
