require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspace = {
          work = '~/neorg/work',
          home = '~/neorg/home',
        }
      }
    },
    -- ["core.gtd.base"] = {},
    -- ["core.norg.completion"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.qol.toc"] = {},
    ["core.presenter"] = {},
  }
}
