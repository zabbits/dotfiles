local M = {
  "nvim-neorg/neorg",
  cmd = "NeorgStart",
  ft = 'norg',
  dependencies = { "nvim-treesitter" },
}

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
          hook = function(keybinds)
            keybinds.remap("norg", "n", "<CR>", "<cmd>Neorg keybind norg core.norg.esupports.hop.hop-link<CR>")
          end,
        }
      },
      ["core.export"] = {},
      ["core.export.markdown"] = {},
      ["core.presenter"] = {
        config = {
          zen_mode = 'truezen',
        }
      },
      ["core.looking-glass"] = {},
      -- ["core.gtd.base"] = {
      --   config = {
      --     workspace = 'gtd',
      --     syntax = {
      --       context = "#contexts",
      --       start = "#time.start",
      --       due = "#time.due",
      --       waiting = "#waiting.for",
      --     }
      --   }
      -- },
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
          -- icon_preset = 'varied',
          icons = {
            heading = {
              enabled = true,

              level_1 = {
                icon = "",
              },

              level_2 = {
                icon = " ✿",
              },

              level_3 = {
                icon = "  ",
              },

              level_4 = {
                icon = "   ○",
              },

              level_5 = {
                icon = "    ▶",
              },

              level_6 = {
                icon = "     ⤷",
              },
            },

            footnote = {
              single = {
                icon = "",
              },
              multi_prefix = {
                icon = " ",
              },
              multi_suffix = {
                icon = " ",
              },
            },
            delimiter = {
              weak = {
                icon = "⬸",
              },
              strong = {
                icon = "↢",
              },
            }

          }
        }
      },
      ["core.norg.qol.toc"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = 'nvim-cmp'
        }
      },
      ["core.integrations.nvim-cmp"] = {},
    }
  }
end

return M
