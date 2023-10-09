return {
    name = "g++ build & run",
    builder = function()
        -- Full path to current file (see :help expand())
        local output = vim.fn.expand("%:r")
        local file = vim.fn.expand("%:p")
        return {
            cmd = string.format("g++ %s -o %s && %s", file, output, output),
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
