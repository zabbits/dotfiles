return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    enabled = true,
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind.nvim",
        {
            "garymjr/nvim-snippets",
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
            opts = {
                friendly_snippets = true,
                create_cmp_source = true,
            },
        },
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            preselect = cmp.PreselectMode.None,
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                end,
            },
            formatting = {
                format = function(entry, vim_item)
                    return require("lspkind").cmp_format({
                        menu = {
                            buffer = "[Buf]",
                            nvim_lsp = "[LSP]",
                            path = "[Path]",
                            neorg = "[Neorg]",
                            snippets = "[Snip]",
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
                snippets = 1,
                cmp_tabnine = 1,
                buffer = 1,
                path = 1,
            },
            confirm_opts = {
                -- behavior = cmp.ConfirmBehavior.Replace,
                select = true,
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
                { name = "snippets" },
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
                    elseif vim.snippet.active({ direction = 1 }) then
                        vim.snippet.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.snippet.active({ direction = -1 }) then
                        vim.snippet.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
        })
    end,
}
