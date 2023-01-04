local M = {
  'feline-nvim/feline.nvim',
  event = { 'BufRead', 'BufNewFile' },
}

function M.config()
  local feline = _G.safe_require('feline')
  if not feline then
    return
  end
  local status = require "core.status"
  local icons = require("core.icons")

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
      icon = icons.os.linux .. ' '
    elseif os == 'darwin' then
      icon = icons.os.darwin .. ' '
    else
      icon = icons.os.windows .. ' '
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
      icon = icons.git.base .. ' ',
      hl = {
        fg = colors.violet,
      },
      right_sep = ' ',
    },
    {
      provider = 'git_diff_added',
      icon = icons.git.added .. ' ',
      hl = {
        fg = colors.green
      },
      right_sep = ' ',
    },
    {
      provider = 'git_diff_changed',
      icon = icons.git.modified .. ' ',
      hl = {
        fg = colors.orange
      },
      right_sep = ' ',
    },
    {
      provider = 'git_diff_removed',
      icon = icons.git.deleted .. ' ',
      hl = {
        fg = colors.red
      },
      right_sep = ' ',
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
      provider = {
        name = 'file_type',
        opts = {
          filetype_icon = false,
          case = 'lowercase',
        },
      },
      left_sep = {
        str = ' ',
      },
      right_sep = {
        str = ' ',
      },
    },
    {
      provider = function()
        return vim.bo.fileencoding
      end,
      right_sep = {
        str = ' ',
      },
    },
    {
      provider = function()
        return 'space:' .. vim.bo.tabstop
      end,
    },
  }

  local position = {
    {
      provider = 'position',
      left_sep = {
        str = ' ',
      },
      right_sep = {
        str = ' ',
      },
    },
    {
      provider = 'line_percentage',
      right_sep = {
        str = ' ',
      },
    },
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


  -- ===================
  --        Middle
  -- ===================
  table.insert(middle,
    {
      provider = {
        name = 'file_info',
      },
    }
  )


  -- ===================
  --        Right
  -- ===================
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
            -- fg = colors.blue,
            bg = colors.blue,
            style = 'bold'
          },
          right_sep = {
            str = 'right_filled',
          },
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
        "^harpoon$",
        "^TelescopePrompt$",
        "^neo%-tree%-popup$",
      }
    },
    disable = {
      filetypes = {
      }
    }
  })

end

return M
