return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "HiPhish/rainbow-delimiters.nvim",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "rust" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            autotag = {
                enable = true,
            },
            context_commentstring = {
                enable = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = { query = "@function.outer", desc = "outer of fn" },
                        ["if"] = { query = "@function.inner", desc = "inner of fn" },
                        ["ac"] = { query = "@class.outer", desc = "outer of class" },
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc = "inner of class" },
                        -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    include_surrounding_whitespace = false,
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[c"] = "@class.outer",
                    },
                },
            },
        })
    end,
}
