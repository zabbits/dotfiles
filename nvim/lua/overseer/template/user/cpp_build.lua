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
        filetype = { "cpp" },
    },
}
