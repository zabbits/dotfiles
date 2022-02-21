require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspace = {
          work = '~/norg/work',
          home = '~/norg/home',
        }
      }
    },
    -- ["core.gtd.base"] = {},
    -- ["core.norg.completion"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.qol.toc"] = {},
    ["core.presenter"] = {
      config = {
        zen_mode = 'truezen',
      }
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.keybinds"] = {},
  }
}
