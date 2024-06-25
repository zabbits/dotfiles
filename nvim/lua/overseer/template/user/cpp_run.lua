return {
    name = "g++ run",
    builder = function()
        -- see :help expand()
        local output = vim.fn.expand("%:p:r")
        return {
            cmd = { output },
            components = {
                { "dependencies",       task_names = { "g++ build" } },
                { "on_output_quickfix", set_diagnostics = true,      open = true },
                "on_result_diagnostics",
                { "display_duration",    detail_level = 2 },
                "on_output_summarize",
                "on_exit_set_status",
                { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
                -- "default",
            },
        }
    end,
    condition = {
        filetype = { "cpp" },
    },
}
