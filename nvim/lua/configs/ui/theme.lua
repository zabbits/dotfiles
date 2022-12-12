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

-- 浅灰色：#D3D3D3
-- 淡紫色：#D8BFD8
-- 淡粉色：#FFB6C1
-- 淡黄色：#FFFFE0
-- 淡绿色：#90EE90
-- 淡蓝色：#ADD8E6
-- 淡紫红色：#DB7093
-- 淡紫罗兰色：#E6E6FA
-- 淡青色：#D1EEEE
-- 淡棕色：#F5F5DC
-- 淡红色：#FFE4E1
-- 淡橙色：#FFEBCD
-- 淡黄绿色：#98FB98
-- 淡靛蓝：#87CEEB
-- 淡紫紫：#E0FFFF
-- 淡紫棕色：#E6E6CD
-- 淡紫褐色：#EBCCD1
-- 淡紫灰色：#DCD0FF
-- 淡紫黑色：#DDA0DD
-- 淡紫金色：#DDA0DD
-- 浅黄色：#FFFACD
-- 淡红褐色：#F5DEB3
-- 淡绿青色：#00FFFF
-- 淡黄绿色：#7FFFD4
-- 淡紫红色：#DDA0DD
-- 淡紫棕色：#D2B48C
-- 淡紫灰色：#BEBEBE
-- 淡紫黑色：#6B8E23
-- 淡紫金色：#EEE8AA
-- 淡紫银色：#C0C0C0
-- 淡紫青色：#87CEEB
-- 淡紫褐色：#B0C4DE
-- 淡紫绿色：#00FF00
-- 淡紫蓝色：#00FFFF
-- 淡紫紫色：#E0FFFF
-- 淡紫黑色：#000000

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
          base = "#161A17",
          mantle = "#212420",
          crust = "#2A262A",
          text = cnc.liqiu.cangcang,
          yellow = '#FFFFE0',
          peach = '#FFB6C1',
          green = '#90EE90',
          mauve = '#E6E6CD',
          lavender = '#00FFFF',
          teal = '#DDA0DD',
          blue = '#ADD8E6',
          sky = '#00FFFF',
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
  vim.cmd.colorscheme("tokyodark")
  -- vim.cmd.colorscheme(set_kanagawa())
end

return M
