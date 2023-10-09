return {
    name = "g++ build",
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        local output = vim.fn.expand("%:p:r")
        return {
            cmd = { "g++" },
            args = {
                -- level up warning lv
                "-Wall",
                "-Weffc++",
                "-Wextra",
                "-Wconversion",
                "-Wsign-conversion",
                -- treat warning as error, i don't want this
                -- "-Werror",

                -- remove compile extensions
                "-pedantic-errors",
                -- compile for debug
                "-ggdb",
                -- using c++17 std
                "-std=c++17",
                "-o",
                output,
                file,
            },
            components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
    condition = {
        filetype = { "cpp" },
    },
}
