return {
    name = "g++ run folder",
    builder = function()
        -- see :help expand()
        local output = vim.fn.expand("%:p:r")
        return {
            cmd = { output },
            components = {
                { "dependencies", task_names = { "g++ build folder" } },
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
