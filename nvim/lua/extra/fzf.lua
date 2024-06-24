return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            "borderless_full",
            winopts = {
                preview = {
                    layout   = 'vertical',
                    vertical = 'down:65%',
                },
                on_create = function()
                    -- use Ctrl-r paste register
                    vim.keymap.set("t", "<C-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']],
                        { expr = true, buffer = true })
                end,
            },

            keymap  = {
                builtin = {
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
                fzf = {
                    ["ctrl-d"] = "preview-page-down",
                    ["ctrl-u"] = "preview-page-up",
                },
            },
        })
    end
}
