return {
    name = "g++ run",
    builder = function()
        -- Full path to current file (see :help expand())
        local output = vim.fn.expand("%:r")
        return {
            cmd = { "./" .. output },
            components = {
                { "on_output_quickfix", set_diagnostics = true },
                "on_result_diagnostics",
                "default",
            },
        }
    end,
    condition = {
        filetype = { "cpp" },
    },
}
