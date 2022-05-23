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
    red = '#e86671',
    c1 = '#957FB8',
    c2 = '#658594',
    c3 = '#727169',
  }

  local left = {}
  local middle = {}
  local right = {}

  local space = {
    provider = '',
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
      right_sep = ' ',
    },
    {
      provider = 'git_diff_added',
      icon = ' ',
      hl = {
        fg = colors.green
      },
      right_sep = ' ',
    },
    {
      provider = 'git_diff_changed',
      icon = ' ',
      hl = {
        fg = colors.orange
      },
      right_sep = ' ',
    },
    {
      provider = 'git_diff_removed',
      icon = ' ',
      hl = {
        fg = colors.red
      },
      right_sep = ' ',
    },
  }

  local diagnostic = {
    {
      provider = function()
        return tostring(status.diagnostic.error.count())
      end,
      icon = status.diagnostic.error.icon .. ' ',
      hl = {
        fg = colors.red,
      },
    },
    {
      provider = function()
        return tostring(status.diagnostic.warning.count())
      end,
      icon = status.diagnostic.warning.icon .. ' ',
      hl = {
        fg = colors.yellow
      },
    },
    {
      provider = function()
        return tostring(status.diagnostic.hint.count())
      end,
      icon = status.diagnostic.hint.icon .. ' ',
      hl = {
        fg = colors.blue
      },
    },
    {
      provider = function()
        return tostring(status.diagnostic.info.count())
      end,
      icon = status.diagnostic.info.icon .. ' ',
      hl = {
        fg = colors.cyan
      },
    },
  }

  local lsp = {
    provider = 'lsp_client_names',
    icon = '  ',
    hl = {
      -- fg = colors.yellow,
      bg = colors.c1,
    },
    right_sep = {
      str = '',
      hl = {
        -- fg = colors.yellow,
        bg = colors.c1,
      },
    },
  }

  local treesitter = {
    provider = function()
      return status.treesitter_status()
    end,
    hl = {
      -- fg = colors.yellow,
      bg = colors.c1,
    },
    left_sep = {
      str = 'left_filled',
      hl = {
        -- fg = colors.yellow,
        fg = colors.c1,
      },
      always_visible = true,
    },
    right_sep = {
      str = ' ',
      hl = {
        -- fg = colors.yellow,
        bg = colors.c1,
      },
      always_visible = true,
    },
  }

  local file_info = {
    {
      provider = file_osinfo,
      hl = {
        bg = colors.c2,
        style = 'bold'
      },
      left_sep = {
        str = 'left_filled',
        hl = {
          fg = colors.c2,
          bg = colors.c1,
          -- fg = colors.yellow,
          -- fg = colors.skyblue,
        },
      },
      right_sep = {
        str = ' ',
        hl = {
          bg = colors.c2,
        },
      },
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
        bg = colors.c2,
        style = 'bold'
      },
      right_sep = {
        str = ' ',
        hl = {
          bg = colors.c2,
        },
      },
    },
    {
      provider = function()
        return vim.bo.fileencoding
      end,
      hl = {
        bg = colors.c2,
        style = 'bold'
      },
      right_sep = {
        str = ' ',
        hl = {
          bg = colors.c2,
        },
      },
    },
  }

  local position = {
    {
      provider = 'position',
      left_sep = {
        str = 'left_filled',
        hl = {
          bg = colors.c2,
          fg = colors.c3,
        }
      },
      right_sep = {
        str = ' ',
        hl = {
          bg = colors.c3,
        },
      },
      hl = {
        bg = colors.c3,
      },
    },
    {
      provider = 'line_percentage',
      hl = {
        bg = colors.c3,
        style = 'bold'
      },
      right_sep = {
        str = ' ',
        hl = {
          bg = colors.c3,
        },
      },
    },
    {
      provider = 'scroll_bar',
      hl = {
        fg = colors.blue,
        bg = colors.c3,
        style = 'bold'
      },
    }
  }


  -- ===================
  --        Left
  -- ===================
  table.insert(left, vim_mode)
  table.insert(left, space)
  for _, val in pairs(git) do
    table.insert(left, val)
  end
  table.insert(left, space)
  for _, val in pairs(diagnostic) do
    table.insert(left, val)
    table.insert(left, space)
  end
  table.insert(left, space)


  -- ===================
  --        Middle
  -- ===================


  -- ===================
  --        Right
  -- ===================
  table.insert(right, treesitter)
  table.insert(right, lsp)
  for _, val in pairs(file_info) do
    table.insert(right, val)
  end
  for _, val in pairs(position) do
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
