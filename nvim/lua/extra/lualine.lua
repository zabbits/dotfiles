return {
    "nvim-lualine/lualine.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                {
                    "filename",
                    symbols = {
                        modified = "", -- Text to show when the file is modified.
                        readonly = "", -- Text to show when the file is non-modifiable or readonly.
                        unnamed = "[No Name]", -- Text to show for unnamed buffers.
                        newfile = "", -- Text to show for newly created file before first write
                    },
                },
            },
            lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        extensions = {
            "aerial",
            "lazy",
            "trouble",
            "toggleterm",
            "quickfix",
            "neo-tree",
        },
    },
    config = function(_, opts)
        ---@type table<string, string?>
        local progress_status = {
            client = nil,
            kind = nil,
            title = nil,
        }

        vim.api.nvim_create_autocmd("LspProgress", {
            group = vim.api.nvim_create_augroup("lsp_progress", { clear = true }),
            desc = "Update LSP progress in statusline",
            pattern = { "begin", "end" },
            callback = function(args)
                -- This should in theory never happen, but I've seen weird errors.
                if not args.data then
                    return
                end

                progress_status = {
                    client = vim.lsp.get_client_by_id(args.data.client_id).name,
                    kind = args.data.result.value.kind,
                    title = args.data.result.value.title,
                }

                if progress_status.kind == "end" then
                    progress_status.title = nil
                    -- Wait a bit before clearing the status.
                    vim.defer_fn(function()
                        vim.cmd.redrawstatus()
                    end, 3000)
                else
                    vim.cmd.redrawstatus()
                end
            end,
        })
        --- The latest LSP progress message.
        ---@return string
        local function lsp_progress_component()
            if not progress_status.client or not progress_status.title then
                return ""
            end

            return table.concat({
                "%#StatuslineSpinner#󱥸 ",
                string.format("%%#StatuslineTitle#%s  ", progress_status.client),
                string.format("%%#StatuslineItalic#%s...", progress_status.title),
                color = "StatusLine",
            })
        end

        table.insert(opts.sections.lualine_x, 1, lsp_progress_component)

        require("lualine").setup(opts)
    end,
}
