local wezterm = require 'wezterm'

return {
  font_size = 19.5,
  -- // 哈哈哈哈
  font = wezterm.font_with_fallback {
    {
      family = "Comic Shanns",
      weight = "Regular", 
      stretch = "Normal",
      style = "Normal"
    },
    {
      family = "Comic Mono",
      weight = "Regular", 
      stretch = "Normal",
      style = "Normal"
    },
    {
      family = "Maple Mono SC NF",
      weight = "Regular",
      stretch = "Normal",
      style = "Normal"
    },
    {
      family = 'FiraCode Nerd Font Mono',
      weight = 450,
      stretch = 'Normal',
      style = 'Normal',
      harfbuzz_features = {
      },
    },
    'JetBrains Mono',
  },

  window_decorations = "RESIZE",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  -- window_decorations = "NONE",

  -- for nvim kanagawa colorscheme
  force_reverse_video_cursor = true,
  colors = {
    foreground = "#dcd7ba",
    background = "#1f1f28",

    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#16161d",
    split = "#16161d",

    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  },
}
