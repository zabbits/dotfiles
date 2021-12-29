local ok, feline = pcall(require, 'feline')
if not ok then
  return
end

local color = {
  bg = '#3b4261',
  fg = '#7aa2f7',
}

local mode_cpt = {
  {
    provider = 'vi_mode',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
}

local file_cpt = {
  {
    provider = 'file_info',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'file_encoding',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'file_format',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'file_size',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'position',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'scroll_bar',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
}

local git_cpt = {
  {
    provider = 'git_branch',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'git_diff_added',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'git_diff_removed',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'git_diff_changed',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
}

local lsp_cpt = {
  {
    provider = 'diagnostic_errors',
    icon = '',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'diagnostic_warnings',
    icon = '',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
  {
    provider = 'lsp_client_names',
    icon = ' LSP:',
    right_sep = {
      str = ' ',
    },
    hl = {
      fg = color.fg,
      bg = color.bg,
    },
  },
}



local components = {
  active = {
    mode_cpt,
    git_cpt,
    lsp_cpt,
    file_cpt,
  },
  inactive = {
    {
      provider = 'file_type',
      right_sep = {
        str = ' '
      },
    },
    {
      provider = 'file_type',
      right_sep = {
        str = ' '
      },
    },
  }
}
feline.setup({
  components = components,
  colors = {
    bg = color.bg,
    fg = color.fg,
  },
})
