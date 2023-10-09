return {
    name = "g++ build & run",
    builder = function()
        -- see :help expand()
        local output = vim.fn.expand("%:p:r")
        return {
            cmd = { output },
            components = {
                { "dependencies", task_names = { "g++ build" } },
                { "on_output_quickfix", set_diagnostics = true, open = true },
                "on_result_diagnostics",
                "default",
            },
        }
    end,
    condition = {
        filetype = { "cpp" },
    },
}
