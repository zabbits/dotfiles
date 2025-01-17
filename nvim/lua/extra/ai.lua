return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = "*", -- set this to "*" if you want to always pull the latest change, false to update on release
    opts = {
        -- add any opts here
        ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = "gemini", -- Recommend using Claude
        auto_suggestions_provider = "gemini",
        gemini = {
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
            model = "gemini-2.0-flash-exp",
            timeout = 30000, -- Timeout in milliseconds
            temperature = 0,
            max_tokens = 8192,
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
    },
}
