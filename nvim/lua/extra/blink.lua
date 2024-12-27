return {
    {
        "saghen/blink.cmp",
        version = "*",
        build = "cargo build --release",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        event = "InsertEnter",
        opts = {
            keymap = {
                preset = "enter",
                ["<Enter>"] = { "select_and_accept", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                cmdline = {
                    ["<Enter"] = {
                        function(cmp)
                            cmp.select_and_accept()
                        end,
                        "fallback",
                    },
                },
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
                list = {
                    selection = "auto_insert",
                },
                menu = {
                    auto_show = true,
                    -- nvim-cmp style menu
                    draw = {
                        columns = {
                            { "kind_icon", "label", "label_description", gap = 1 },
                            { "kind", gap = 1 },
                        },
                    },
                },
                ghost_text = { enabled = true },
            },
        },
    },
}
