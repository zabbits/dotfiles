return {
    "numToStr/Comment.nvim",
    keys = {
        {
            "gc",
            mode = { "n", "v" },
        },
        {
            "<C-/>",
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            mode = "n",
            desc = "Comment",
        },
    },
    config = function()
        require("Comment").setup({
            {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            },
        })
    end,
}
