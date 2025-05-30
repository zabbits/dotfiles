return {
    {
        "saghen/blink.cmp",
        version = "*",
        -- build = "cargo build --release",
        enabled = true,
        dependencies = {
            "rafamadriz/friendly-snippets",
            "Kaiser-Yang/blink-cmp-avante",
            {
                "saghen/blink.compat",
                version = "*",
                -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
                lazy = true,
                -- make sure to set opts so that lazy.nvim calls blink.compat's setup
                opts = {},
            },
        },
        event = "InsertEnter",
        opts = {
            keymap = {
                preset = "enter",
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "avante", "lsp", "path", "snippets", "buffer" },
                providers = {
                    avante = {
                        module = "blink-cmp-avante",
                        name = "Avante",
                        opts = {
                            -- options for blink-cmp-avante
                        },
                    },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            completion = {
                menu = {
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", gap = 1, "kind" },
                        },
                    },
                },
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = { enabled = false },
            },
            signature = { enabled = true },
        },
    },
}
