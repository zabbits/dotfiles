local M = {
  'b0o/incline.nvim',
}

local function get_diagnostic_label(props)
  local diagnostic = require('core.status').diagnostic

  local order = {
    'Error',
    'Warn',
    'Hint',
    'Info',
  }

  local label = {}
  for _, val in ipairs(order) do
    local type = diagnostic[string.lower(val)]
    local n = type.count(props.buf)
    if n > 0 then
      table.insert(label, { ' ' .. type.icon .. ' ' .. n, group = 'DiagnosticSign' .. val })
    end
  end
  return label
end

function M.config()
  local incline = safe_require('incline')
  if not incline then
    return
  end

  incline.setup {
    debounce_threshold = {
      falling = 50,
      rising = 10
    },
    hide = {
      cursorline = false,
      focused_win = false,
      only_win = false
    },
    highlight = {
      groups = {
        InclineNormal = {
          default = true,
          group = "NormalFloat"
        },
        InclineNormalNC = {
          default = true,
          group = "NormalFloat"
        }
      }
    },
    ignore = {
      buftypes = "special",
      filetypes = {},
      floating_wins = true,
      unlisted_buffers = true,
      wintypes = "special"
    },
    render = function(props)
      local diagnostics = get_diagnostic_label(props)

      return diagnostics
    end,
    window = {
      margin = {
        horizontal = 1,
        vertical = 1
      },
      options = {
        signcolumn = "no",
        wrap = false
      },
      padding = 1,
      padding_char = " ",
      placement = {
        horizontal = "right",
        vertical = "top"
      },
      width = "fit",
      winhighlight = {
        active = {
          EndOfBuffer = "None",
          Normal = "InclineNormal",
          Search = "None"
        },
        inactive = {
          EndOfBuffer = "None",
          Normal = "InclineNormalNC",
          Search = "None"
        }
      },
      zindex = 50
    }
  }

end

return M
