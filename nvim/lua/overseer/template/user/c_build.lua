return {
    name = "c build",
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        local output = vim.fn.expand("%:p:r")
        return {
            cmd = { "gcc" },
            args = {
                "-o",
                output,
                file,
            },
            components = { { "on_output_quickfix", open = true },

                { "display_duration",   detail_level = 2 },
                "on_output_summarize",
                "on_exit_set_status",
                { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
                -- "default"
            },
        }
    end,
    condition = {
        filetype = { "c" },
    },
}
