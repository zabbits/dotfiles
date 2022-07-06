local M = {}

function M.config()
  local present, norg = pcall(require, "neorg")
  if not present then
    return
  end
  norg.setup {
    load = {
      ["core.defaults"] = {},
      ["core.keybinds"] = {
        config = {
          default_keybinds = true,
        }
      },
      ["core.export"] = {},
      ["core.export.markdown"] = {},
      ["core.presenter"] = {
        config = {
          zen_mode = 'truezen',
        }
      },
      ["core.gtd.base"] = {
        config = {
          workspace = 'gtd',
          syntax = {
            context = "#contexts",
            start = "#time.start",
            due = "#time.due",
            waiting = "#waiting.for",
          }
        }
      },
      ["core.norg.journal"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work = '~/norg/work',
            home = '~/norg/home',
            note = '~/norg/note',
            gtd = '~/norg/gtd',
          }
        }
      },
      ["core.norg.manoeuvre"] = {},
      ["core.norg.concealer"] = {
        config = {
          icon_preset = 'varied',
        }
      },
      ["core.norg.qol.toc"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = 'nvim-cmp'
        }
      },
      ["core.integrations.nvim-cmp"] = {},
      ["core.integrations.telescope"] = {},
    }
  }

  local neorg_callbacks = require("neorg.callbacks")
  neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
      n = { -- Bind keys in normal mode
        { "<C-s>", "core.integrations.telescope.find_linkable" },
      },

      i = { -- Bind in insert mode
        { "<C-l>", "core.integrations.telescope.insert_link" },
      },
    }, {
      silent = true,
      noremap = true,
    })
  end)
end

return M
