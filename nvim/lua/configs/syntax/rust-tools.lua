local M = {}

function M.config()
  local rt = safe_require("rust-tools")
  local handlers = safe_require('configs.lsp.handlers')
  if not rt or not handlers then
    return
  end
  local path = vim.env.HOME .. '/home/zbs/.local/share/nvim/mason/packages/codelldb'
  local codelldb_path = path .. 'codelldb'
  local liblldb_path = path .. '/extension/lldb/lib/liblldb.so'

  rt.setup({
    tools = {
      -- These apply to the default RustSetInlayHints command
      inlay_hints = {
        -- automatically set inlay hints (type hints)
        -- default: true
        auto = true,

        -- Only show inlay hints for the current line
        only_current_line = false,

        -- whether to show parameter hints with the inlay hints or not
        -- default: true
        show_parameter_hints = true,

        -- prefix for parameter hints
        -- default: "<-"
        parameter_hints_prefix = "<- ",

        -- prefix for all the other hints (type, chaining)
        -- default: "=>"
        other_hints_prefix = "=> ",

        -- whether to align to the lenght of the longest line in the file
        max_len_align = false,

        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,

        -- whether to align to the extreme right or not
        right_align = false,

        -- padding from the right if right_align is true
        right_align_padding = 7,

        -- The color of the hints
        highlight = "Comment",
      },
      -- options same as lsp hover / vim.lsp.util.open_floating_preview()
      hover_actions = {

        -- the border that is used for the hover window
        -- see vim.api.nvim_open_win()
        border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        },

        -- whether the hover action window gets automatically focused
        -- default: false
        auto_focus = true,
      },
      -- options right now: termopen / quickfix
      executor = require("rust-tools/executors").termopen,
    },
    server = {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
    },
    -- dap = {
    --   adapter = require('rust-tools.dap').get_codelldb_adapter(
    --     codelldb_path, liblldb_path)
    -- }
  })
end

return M