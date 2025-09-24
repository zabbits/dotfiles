return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = false,
        -- ft = "markdown",
        event = {
            "BufReadPre " .. vim.fn.expand("~") .. "/vaults/*.md",
            "BufNewFile " .. vim.fn.expand("~") .. "/vaults/*.md",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/vaults/nichijou",
                },
            },
            completion = {
                -- Enables completion using nvim_cmp
                nvim_cmp = false,
                -- Enables completion using blink.cmp
                blink = true,
                -- Trigger completion at 2 chars.
                min_chars = 2,
                -- Set to false to disable new note creation in the picker
                create_new = true,
            },
            ui = {
                enable = false, -- set to false to disable all additional syntax features
            },
            legacy_commands = false,
            preferred_link_style = "markdown",
            disable_frontmatter = true,
            note_frontmatter_func = function(note)
                -- Add the title of the note as an alias.
                if note.title then
                    note:add_alias(note.title)
                end

                local out = {
                    id = note.id,
                    date = note.date,
                    lastMod = note.lastNod,
                    category = note.category,
                    tags = note.tags,
                }

                -- `note.metadata` contains any manually added fields in the frontmatter.
                -- So here we just make sure those fields are kept in the frontmatter.
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end
                return out
            end,
        },
    },
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",
        opts = {},
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {
            completions = { lsp = { enabled = true } },
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
}
