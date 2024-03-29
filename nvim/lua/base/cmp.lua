return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind.nvim",
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                vim.api.nvim_create_autocmd("InsertLeave", {
                    callback = function()
                        local om = vim.v.event.old_mode
                        local nm = vim.v.event.new_mode
                        if
                            ((om == "s" and nm == "n") or om == "i")
                            and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                            and not require("luasnip").session.jump_active
                        then
                            require("luasnip").unlink_current()
                        end
                    end,
                })
            end,
        },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        -- autopair integration
        -- local pair_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
        -- if pair_ok then
        --     cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        -- end

        cmp.setup({
            preselect = cmp.PreselectMode.None,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            formatting = {
                format = function(entry, vim_item)
                    return require("lspkind").cmp_format({
                        menu = {
                            buffer = "[Buf]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            path = "[Path]",
                            neorg = "[Neorg]",
                            orgmode = "[Org]",
                            latex_symbols = "[LaTeX]",
                            crates = "[Crates]",
                        },
                        maxwidth = 30,
                        ellipsis_char = "...",
                        with_text = false,
                    })(entry, vim_item)
                end,
            },
            duplicates = {
                nvim_lsp = 1,
                snippy = 1,
                luasnip = 1,
                cmp_tabnine = 1,
                buffer = 1,
                path = 1,
            },
            confirm_opts = {
                -- behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                documentation = {
                    border = "rounded",
                },
                completion = {
                    border = "rounded",
                },
            },
            experimental = {
                ghost_text = false,
            },
            completion = {
                keyword_length = 1,
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "neorg" },
                { name = "orgmode" },
                { name = "buffer" },
                { name = "path" },
                { name = "crates" },
            },
            mapping = {
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                ["<C-y>"] = cmp.config.disable,
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
        })
    end,
}
