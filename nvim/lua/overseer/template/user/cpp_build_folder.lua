return {
    name = "g++ build folder",
    builder = function()
        -- Full path to current file (see :help expand())
        local output = vim.fn.expand("%:p:r")
        -- current file directory
        local file_path = vim.fn.expand("%:p:h")
        -- list file endwith cpp,cc,h
        local dir = require("plenary.scandir")
        local files = dir.scan_dir(file_path, {
            search_pattern = {
                "%.cc$",
                "%.cpp$",
                "%.h$",
            },
        })
        local args = {
            -- level up warning lv
            "-Wall",
            "-Weffc++",
            "-Wextra",
            "-Wconversion",
            "-Wsign-conversion",
            -- treat warning as error, i don't want this
            -- "-Werror",
            -- -I: include directory
            -- "-I/home/zbs/project/cpp/ch2/header/others",

            -- remove compile extensions
            "-pedantic-errors",
            -- compile for debug
            "-ggdb",
            -- using c++17 std
            "-std=c++17",
            "-o",
            output,
        }
        vim.list_extend(args, files)
        return {
            cmd = { "g++" },
            args = args,
            components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
    condition = {
        filetype = { "cpp" },
    },
}
