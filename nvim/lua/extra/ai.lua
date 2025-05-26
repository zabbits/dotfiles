return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        enabled = true,
        lazy = false,
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = "xai",
            vendors = {
                ["xai"] = {
                    __inherited_from = "openai",
                    -- __inherited_from = "openai",
                    api_key_name = "XAI_API_KEY",
                    endpoint = "https://api.x.ai/v1",
                    model = "grok-3-beta",
                },
            },
            -- for mcphub
            disabled_tools = {
                "list_files",
                "search_files",
                "read_file",
                "create_file",
                "rename_file",
                "delete_file",
                "create_dir",
                "rename_dir",
                "delete_dir",
                "bash",
            },
            system_prompt = function()
                local hub = require("mcphub").get_hub_instance()
                return hub:get_active_servers_prompt()
            end,
            custom_tools = function()
                return {
                    require("mcphub.extensions.avante").mcp_tool(),
                }
            end,
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "ravitemer/mcphub.nvim",
        },
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
        },
        -- comment the following line to ensure hub will be ready at the earliest
        cmd = "MCPHub", -- lazy load by default
        build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
        -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
        -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
        config = function()
            require("mcphub").setup({
                auto_approve = false, -- Auto approve mcp tool calls
                auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
                extensions = {
                    avante = {
                        make_slash_commands = true, -- make /slash commands from MCP server prompts
                    },
                    codecompanion = {
                        -- Show the mcp tool result in the chat buffer
                        -- NOTE:if the result is markdown with headers, content after the headers wont be sent by codecompanion
                        show_result_in_chat = true,
                        make_vars = true, -- make chat #variables from MCP server resources
                        make_slash_commands = true, -- make /slash commands from MCP server prompts
                    },
                },
            })
        end,
    },
}
