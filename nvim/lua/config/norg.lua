require('neorg').setup {
  load = {
    ["core.defaults"] = {},
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
    ["core.gtd.base"] = {
      config = {
        workspace = 'gtd',
      }
    },
    ["core.norg.manoeuvre"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.qol.toc"] = {},
    ["core.presenter"] = {
      config = {
        zen_mode = 'truezen',
      }
    },
    ["core.norg.completion"] = {
      config = {
        engine = 'nvim-cmp'
      }
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.keybinds"] = {},
  }
}
