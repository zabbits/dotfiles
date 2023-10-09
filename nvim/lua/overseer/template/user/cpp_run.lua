return {
    name = "g++ run",
    builder = function()
        -- Full path to current file (see :help expand())
        local output = vim.fn.expand("%:p:r")
        return {
            cmd = { output },
            components = {
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
