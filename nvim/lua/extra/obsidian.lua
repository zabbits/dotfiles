return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
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
                {
                    name = "work",
                    path = "~/vaults/work",
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
            preferred_link_style = "markdown",
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
}
