return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            "borderless_full",
            winopts = {
                on_create = function()
                    -- use Ctrl-r paste register
                    vim.keymap.set("t", "<C-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']],
                        { expr = true, buffer = true })
                end,
            },
        })
    end
}
