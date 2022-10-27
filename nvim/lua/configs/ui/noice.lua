local M = {}

function M.config()
  local noice = safe_require('noice');
  local cfg = require('core.configs')
  if not noice or not cfg.noice then
    return
  end

  noice.setup({
    notify = {
      enabled = true,
      view = "notify",
    },
    lsp = {
      progress = {
        enabled = false,
      },
      hover = {
        enabled = false,
      },
      signatrue = {
        enabled =false,
      },
    },
    routes = {
      -- show @record
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    cmdline = {
      view = "cmdline",
      format = {
        search_down = {
          view = "cmdline",
        },
        search_up = {
          view = "cmdline",
        },
      },
    },

  })
end

return M
