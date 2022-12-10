local M = {}

local function set_kanagawa()
  local kanagawa = safe_require('kanagawa')
  local colors = safe_require('kanagawa.colors').setup()
  if kanagawa then
    kanagawa.setup({
      undercurl = false, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true, bold = false },
      statementStyle = { bold = false },
      typeStyle = {},
      variablebuiltinStyle = { italic = true },
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      globalStatus = true, -- adjust window separators highlight for laststatus=3
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {},
      theme = "default", -- Load "default" theme or the experimental "light" theme
    })

    M.bg = colors.bg
    M.fg = colors.fg
    return 'kanagawa'
  end

  return 'default'
end

local cnc = {
  liqiu = {
    cangcang = '#5976ba',
  },
  yushui = {
    kujin = '#e18a3b',
  },
  daxue = {
    quemei = '#788a6f',
    meirenji = '#c35c6a',
  },
  lichun = {
    liuhuang = '#8b7042',
  },
  qiufen = {
    rauncui = '#006d87',
  },
  shuangjiang = {
    chenxiang = '#99806c',
  },
  jingzhe = {
    tuohuang = '#c67915',
  },
  chushu = {
    facui = '#108b96',
  },
  xiaoshu = {
    chiling = '#954024',
  }
}

local function set_cat()
  local cat = safe_require('catppuccin')
  if cat then
    cat.setup({
      flavour = 'mocha',
      term_colors = true,
      color_overrides = {
        all = {
          -- base = "#16161D",
          -- base = "#151d29",
          base = "#181a1f",
          mantle = "#181a1f",
          crust = "#181a1f",
          text = cnc.liqiu.cangcang,
          yellow = cnc.jingzhe.tuohuang,
          peach = cnc.daxue.meirenji,
          green = cnc.daxue.quemei,
          mauve = cnc.chushu.facui,
          lavender = cnc.xiaoshu.chiling,
          teal = cnc.shuangjiang.chenxiang,
          blue = cnc.lichun.liuhuang,
          sky = cnc.liqiu.cangcang,
        },
      },
      custom_highlights = function(colors)
        return {
          Visual = {
            style = {}
          },
          VisualNOS = {
            style = {}
          },
          TelescopeSelection = {
            fg = colors.green,
            bg = colors.base,
            style = { "bold" },
          }
        }
      end,
      styles = {
        comments = { "italic" },
        properties = { "italic" },
        functions = {},
        keywords = { "italic" },
        operators = {},
        conditionals = {},
        loops = {},
        booleans = {},
        numbers = {},
        types = {},
        strings = {},
        variables = {},
      },
      integrations = {
        aerial = true,
        barbar = false,
        beacon = false,
        cmp = true,
        coc_nvim = false,
        dashboard = false,
        fern = false,
        fidget = false,
        gitgutter = false,
        gitsigns = true,
        harpoon = true,
        hop = false,
        illuminate = false,
        leap = false,
        lightspeed = false,
        lsp_saga = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = false,
        neogit = false,
        neotest = false,
        neotree = true,
        noice = false,
        notify = true,
        nvimtree = false,
        overseer = false,
        pounce = false,
        semantic_tokens = false,
        symbols_outline = false,
        telekasten = false,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ts_rainbow = true,
        vim_sneak = false,
        vimwiki = false,
        which_key = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        navic = {
          enabled = true,
          custom_bg = 'NONE',
        },
      },
    })

    local color = require("catppuccin.palettes").get_palette()
    M.fg = color.text
    M.bg = color.base

    return 'catppuccin'
  end

  return 'default'
end

function M.config()
  vim.cmd.colorscheme(set_cat())
  -- vim.cmd.colorscheme(set_kanagawa())
end

return M
