return {
    {
        "saghen/blink.cmp",
        version = "*",
        build = "cargo build --release",
        dependencies = {
            {
                "garymjr/nvim-snippets",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
                opts = {
                    friendly_snippets = true,
                    create_cmp_source = false,
                },
            },
        },
        event = "InsertEnter",
        opts = {
            keymap = {
                preset = "enter",
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
                list = {
                    selection = "auto_insert",
                },
            },
        },
    },
}
