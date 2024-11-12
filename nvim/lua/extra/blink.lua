return {
    {
        "saghen/blink.cmp",
        version = "*",
        build = "cargo build --release",
        opts_extend = {
            "sources.completion.enabled_providers",
            "sources.compat",
        },
        dependencies = {
            -- "rafamadriz/friendly-snippets",
            -- add blink.compat to dependencies
            -- { "saghen/blink.compat", opts = {} },
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
            highlight = {
                -- sets the fallback highlight groups to nvim-cmp's highlight groups
                -- useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release, assuming themes add support
                use_nvim_cmp_as_default = false,
            },
            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
            windows = {
                autocomplete = {
                    -- draw = "reversed",
                    -- winblend = vim.o.pumblend,
                },
                documentation = {
                    auto_show = true,
                },
                ghost_text = {
                    enabled = false,
                },
            },

            -- experimental auto-brackets support
            accept = { auto_brackets = { enabled = true } },

            -- experimental signature help support
            -- trigger = { signature_help = { enabled = true } }
            sources = {
                -- adding any nvim-cmp sources here will enable them
                -- with blink.compat
                compat = {},
                completion = {
                    -- remember to enable your providers here
                    enabled_providers = { "lsp", "path", "snippets", "buffer" },
                },
                path = { name = "Path", module = "blink.cmp.sources.path", score_offset = 4 },
                lsp = { name = "LSP", module = "blink.cmp.sources.lsp", score_offset = 3 },
                snippets = { name = "Snippets", module = "blink.cmp.sources.snippets", score_offset = 2 },
                buffer = { name = "Buffer", module = "blink.cmp.sources.buffer", score_offset = 1 },
            },

            keymap = {
                preset = "enter",
            },
        },
        config = function(_, opts)
            -- setup compat sources
            local enabled = opts.sources.completion.enabled_providers
            for _, source in ipairs(opts.sources.compat or {}) do
                opts.sources.providers[source] = vim.tbl_deep_extend(
                    "force",
                    { name = source, module = "blink.compat.source" },
                    opts.sources.providers[source] or {}
                )
                if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
                    table.insert(enabled, source)
                end
            end
            require("blink.cmp").setup(opts)
        end,
    },
}
