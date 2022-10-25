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
  color_scheme = "Catppuccin Mocha",
}
