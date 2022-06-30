local M = {}

function M.config()
  local orgmode = _G.safe_require("orgmode")
  orgmode.setup_ts_grammar()

  orgmode.setup({
    org_agenda_files = {'~/org/*'},
    org_default_notes_file = '~/org/refile.org',
  })

  require("cmp").setup({
    sources = {
      {name = "orgmode"}
    }
  })
end

return M
