return {
    {
        "saghen/blink.cmp",
        version = "*",
        build = "cargo build --release",
        enabled = false,
        dependencies = {
            "rafamadriz/friendly-snippets",
            {
                "saghen/blink.compat",
                version = "*",
                -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
                lazy = true,
                -- make sure to set opts so that lazy.nvim calls blink.compat's setup
                opts = {},
            },
            {
                "xzbdmw/colorful-menu.nvim",
                config = function()
                    -- You don't need to set these options.
                    require("colorful-menu").setup({
                        ls = {
                            lua_ls = {
                                -- Maybe you want to dim arguments a bit.
                                arguments_hl = "@comment",
                            },
                            gopls = {
                                -- When true, label for field and variable will format like "foo: Foo"
                                -- instead of go's original syntax "foo Foo".
                                add_colon_before_type = false,
                            },
                            ["typescript-language-server"] = {
                                extra_info_hl = "@comment",
                            },
                            ["typescript-tools"] = {
                                extra_info_hl = "@comment",
                            },
                            ts_ls = {
                                extra_info_hl = "@comment",
                            },
                            tsserver = {
                                extra_info_hl = "@comment",
                            },
                            vtsls = {
                                extra_info_hl = "@comment",
                            },
                            ["rust-analyzer"] = {
                                -- Such as (as Iterator), (use std::io).
                                extra_info_hl = "@comment",
                            },
                            clangd = {
                                -- Such as "From <stdio.h>".
                                extra_info_hl = "@comment",
                            },
                            roslyn = {
                                extra_info_hl = "@comment",
                            },

                            -- If true, try to highlight "not supported" languages.
                            fallback = true,
                        },
                        -- If the built-in logic fails to find a suitable highlight group,
                        -- this highlight is applied to the label.
                        fallback_highlight = "@variable",
                        -- If provided, the plugin truncates the final displayed text to
                        -- this width (measured in display cells). Any highlights that extend
                        -- beyond the truncation point are ignored. Default 60.
                        max_width = 60,
                    })
                end,
            },
        },
        event = "InsertEnter",
        config = function()
            require("blink.cmp").setup({
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
                        -- draw = {
                        --     columns = {
                        --         { "kind_icon", "label", "label_description", gap = 1 },
                        --         { "kind", gap = 1 },
                        --     },
                        -- },
                        draw = {
                            -- We don't need label_description now because label and label_description are already
                            -- conbined together in label by colorful-menu.nvim.
                            columns = { { "kind_icon" }, { "label", gap = 1 } },
                            components = {
                                label = {
                                    text = require("colorful-menu").blink_components_text,
                                    highlight = require("colorful-menu").blink_components_highlight,
                                },
                            },
                        },
                    },
                    ghost_text = { enabled = false },
                },
                sources = {
                    default = {
                        "lsp",
                        "path",
                        "snippets",
                        "buffer",
                        "avante_commands",
                        "avante_mentions",
                        "avante_files",
                    },
                    providers = {
                        avante_commands = {
                            name = "avante_commands",
                            module = "blink.compat.source",
                            score_offset = 90, -- show at a higher priority than lsp
                            opts = {},
                        },
                        avante_files = {
                            name = "avante_commands",
                            module = "blink.compat.source",
                            score_offset = 100, -- show at a higher priority than lsp
                            opts = {},
                        },
                        avante_mentions = {
                            name = "avante_mentions",
                            module = "blink.compat.source",
                            score_offset = 1000, -- show at a higher priority than lsp
                            opts = {},
                        },
                    },
                },
            })
        end,
    },
}
