return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        keys = {"<leader>d"},
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            { "rcarriga/nvim-dap-ui", opts = {} },
        },
        opts = {
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        },
    },
}
