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
      overrides = {
        TreesitterContext = { bg = colors.bg_menu_sel },
        TreesitterContextLineNumber = { fg = colors.fn }
      },
      theme = "default" -- Load "default" theme or the experimental "light" theme
    })

    M.bg = colors.bg
    M.fg = colors.fg
    return 'kanagawa'
  end

  return 'default'
end

local function set_zephyr()
  local zephyr = safe_require('zephyr')
  if zephyr then
    M.bg = zephyr.bg
    M.fg = zephyr.fg

    return 'zephyr'
  end

  return 'default'
end

local function set_cat()
  local cat = safe_require('catppuccin')
  if cat then
    local color = require("catppuccin.palettes").get_palette()
    M.fg = color.text
    M.bg = color.base
    cat.setup({
      flavour = 'mocha',
      term_colors = true,
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        keywords = { 'italic' },
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
        which_key = false,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        navic = {
          enabled = true,
          custom_bg = 'NONE',
        },
      }
    })

    return 'catppuccin'
  end

  return 'default'
end

function M.config()
  vim.cmd.colorscheme(set_cat())
end

return M
