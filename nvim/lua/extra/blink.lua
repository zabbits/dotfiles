return {
    {
        "saghen/blink.cmp",
        version = false,
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
                ["<Enter>"] = {
                    function(cmp)
                        if cmp.is_visible() then
                            local completion_list = require("blink.cmp.completion.list")
                            local idx = completion_list.selected_item_idx or 1
                            if idx then
                                return cmp.accept({ index = idx })
                            end
                        end
                    end,
                    "fallback",
                },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.is_visible() then
                            return cmp.select_next()
                        else
                            return cmp.snippet_forward()
                        end
                    end,
                    "fallback",
                },
                cmdline = {
                    preset = "enter",
                },
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
