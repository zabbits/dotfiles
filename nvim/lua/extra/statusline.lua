return {
    "sontungexpt/sttusline",
    branch = "table_version",
    event = { "BufRead", "BufNewFile" },
    opts = {
        components = {
            "mode",
            "os-uname",
            "filename",
            "git-branch",
            "git-diff",
            "diagnostics",
            "%=",
            "lsps-formatters",
            "indent",
            "encoding",
            "pos-cursor",
            "pos-cursor-progress",
        },
    },
    config = function(_, opts)
        require("sttusline").setup(opts)
    end,
}
