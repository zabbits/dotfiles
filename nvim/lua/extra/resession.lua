return {
    "stevearc/resession.nvim",
    keys = {
        {
            "<leader>ss",
            function()
                require("resession").save()
            end,
            desc = "Session Save",
        },
        {

            "<leader>sl",
            function()
                require("resession").load()
            end,
            desc = "Session Load",
        },
        {

            "<leader>sd",
            function()
                require("resession").delete()
            end,
            desc = "Session Delete",
        },
    },
    opts = {},
}
