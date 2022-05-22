local M = {}

function M.config()
  local feline = _G.safe_require('feline')
  if not feline then
    return
  end
  local status = require "core.status"

  local vi_mode_utils = require 'feline.providers.vi_mode'
  local colors = {
    bg = '#282c34',
    fg = '#abb2bf',
    yellow = '#e0af68',
    cyan = '#56b6c2',
    darkblue = '#081633',
    green = '#98c379',
    orange = '#d19a66',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#61afef',
    red = '#e86671'
  }

  local left = {}
  local middle = {}
  local right = {}

  local left_space = {
    provider = '',
    left_sep = {
      str = ' ',
      always_visible = true,
    }
  }
  local right_space = {
    provider = '',
    right_sep = {
      str = ' ',
      always_visible = true,
    }
  }
  local all_space = {
    provider = '',
    left_sep = {
      str = ' ',
      always_visible = true,
    },
    right_sep = {
      str = ' ',
      always_visible = true,
    }
  }

  local function file_osinfo()
    -- local os = vim.bo.fileformat:lower()
    local os = vim.loop.os_uname().sysname:lower()
    local icon
    if os == 'linux' then
      icon = ' '
    elseif os == 'darwin' then
      icon = ' '
    else
      icon = ' '
    end
    return icon .. os
  end

  local vim_mode = {
    provider = {
      name = 'vi_mode',
      opts = {
        show_mode_name = true,
      },
    },
    -- provider = function()
    --   return '▊' .. vi_mode_utils.get_vim_mode()
    -- end,
    hl = function()
      local val = {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = vi_mode_utils.get_mode_color(),
      }
      return val
    end,
  }

  local git = {
    {
      provider = 'git_branch',
      icon = ' ',
      left_sep = ' ',
      hl = {
        fg = colors.violet,
        style = 'bold'
      },
    },
    {
      provider = 'git_diff_added',
      hl = {
        fg = colors.green
      },
    },
    {
      provider = 'git_diff_changed',
      hl = {
        fg = colors.orange
      },
    },
    {
      provider = 'git_diff_removed',
      hl = {
        fg = colors.red
      },
    },
  }

  local diagnostic = {
    {
      provider = 'diagnostic_errors',
      hl = {
        fg = colors.red,
      },
    },
    {
      provider = 'diagnostic_warnings',
      hl = {
        fg = colors.yellow
      },
    },
    {
      provider = 'diagnostic_hints',
      hl = {
        fg = colors.blue
      },
    },
    {
      provider = 'diagnostic_info',
      hl = {
        fg = colors.cyan
      },
    },
  }

  local lsp = {
    provider = 'lsp_client_names',
    icon = '  ',
    hl = {
      fg = colors.yellow
    },
    right_sep = ' ',
  }

  local treesitter = {
    provider = function()
      return status.treesitter_status()
    end,
    hl = {
      fg = colors.yellow
    }
  }

  local file_info = {
    {
      provider = file_osinfo,
      hl = {
        fg = colors.fg,
        style = 'bold'
      },
      right_sep = ' ',
    },
    {
      provider = {
        name = 'file_type',
        opts = {
          filetype_icon = true,
          case = 'lowercase',
        },
      },
      hl = {
        fg = colors.fg,
        style = 'bold'
      },
      right_sep = ' ',
    },
    {
      provider = function()
        return vim.bo.fileencoding
      end,
      hl = {
        fg = colors.fg,
        style = 'bold'
      },
      right_sep = ' ',
    },
  }

  local position = {
    {
      provider = 'position',
      right_sep = ' ',
      hl = {
        fg = colors.blue,
      },
    },
    {
      provider = 'line_percentage',
      hl = {
        fg = colors.blue,
        style = 'bold'
      },
      right_sep = ' ',
    },
    {
      provider = 'scroll_bar',
      hl = {
        fg = colors.blue,
        style = 'bold'
      },
    }
  }


  -- ===================
  --        Left
  -- ===================
  table.insert(left, vim_mode)
  for key, val in pairs(git) do
    table.insert(left, val)
  end
  table.insert(left, right_space)
  for idx, val in pairs(diagnostic) do
    table.insert(left, val)
  end
  table.insert(left, right_space)


  -- ===================
  --        Middle
  -- ===================
  table.insert(middle, treesitter)
  table.insert(middle, right_space)
  table.insert(middle, lsp)


  -- ===================
  --        Right
  -- ===================
  for key, val in pairs(file_info) do
    table.insert(right, val)
  end
  table.insert(right, right_space)
  for key, val in pairs(position) do
    table.insert(right, val)
  end


  local components = {
    active = {
      left,
      middle,
      right,
    },
    inactive = {
      {
        {
          provider = {
            name = 'file_type',
            opts = {
              filetype_icon = false,
              case = 'lowercase',
            },
          },
          hl = {
            fg = colors.blue,
            style = 'bold'
          },
          right_sep = ' ',
        },
      },
    },
  }

  feline.setup({
    components = components,
    force_inactive = {
      filetypes = {
        "^NvimTree$", "^neo%-tree$", "^dashboard$",
        "^Outline$", "^aerial$", "^Trouble$", "^help$",
      }
    },
    disable = {
      filetypes = {
        "^TelescopePrompt$",
      }
    }
  })


  -- set winbar
  local gps_location = function()
    local gps = _G.safe_require("nvim-gps")
    --              﫴        
    if not gps or not gps.is_available() then
      return ""
    end
    local location = gps.get_location()
    if location ~= "" then
      return "    " .. gps.get_location()
    end
    return ""
  end

  local cpt_gps = {
    {
      provider = gps_location,
    }
  }

  feline.winbar.setup({
    components = {
      active = {
        cpt_gps,
      }
    },
    disable = {
      filetypes = {
        "^TelescopePrompt$",
        "^NvimTree$", "^neo%-tree$", "^dashboard$",
        "^Outline$", "^aerial$", "^Trouble$", "^help$",
      }
    },
  })


end

return M
