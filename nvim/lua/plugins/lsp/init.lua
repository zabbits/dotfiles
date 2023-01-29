local lsp_conf = {
  "neovim/nvim-lspconfig",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    "mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "incline.nvim",
    "lspkind.nvim",
    "goto-preview",
    "lsp_signature.nvim",
    "trouble.nvim",
    "lspsaga.nvim",
    "lsp_lines.nvim",
    "fidget.nvim",
  },
  config = function()
    require("neodev").setup({})

    local mason_lsp = require("mason-lspconfig")
    local lspconfig = require('lspconfig')
    local handlers = require('plugins.lsp.handlers')
    handlers.setup()

    for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
      local opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
      }

      local present, av_overrides = pcall(require, "plugins.lsp.server-settings." .. server_name)
      if present then
        opts = vim.tbl_deep_extend("force", av_overrides, opts)
      end
      -- using rust tools for rust
      if server_name ~= "rust_analyzer" then
        lspconfig[server_name].setup(opts)
      end
    end


    -- 是否使用volar
    local configs = require("core.configs")
    if configs.lsp.volar then
      local defaultOpts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
      }
      require("plugins.lsp.vue-volar")
      lspconfig.volar_api.setup(defaultOpts)
      lspconfig.volar_doc.setup(defaultOpts)
      lspconfig.volar_html.setup(defaultOpts)
    end
  end
}


local lspkind_conf = {
  'onsails/lspkind.nvim',
  config = function()
    require('lspkind').init({})
  end
}


local lspsaga_conf = {
  "glepnir/lspsaga.nvim",
  opts = {
    ui = {
      code_action = '',
    },
    lightbulb = {
      enable = true,
      enable_in_insert = true,
      sign = false,
      sign_priority = 40,
      virtual_text = true,
    },
    symbol_in_winbar = {
      enable = true,
      separator = '  ',
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
      respect_root = false,
      color_mode = true,
    },
  }
}


local preview_conf = {
  'rmagatti/goto-preview',
  opts = {},
}


local signature_conf = {
  "ray-x/lsp_signature.nvim",
  opts = {
    floating_window_off_x = 1, -- adjust float windows x position.
    floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
    handler_opts = {
      border = "rounded" -- double, rounded, single, shadow, none
    },
    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = '<C-x>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  }
}


local trouble_conf = {
  "folke/trouble.nvim",
  opts = function()
    local status = require("core.status")
    return {
      indent_lines = false, -- add an indent guide below the fold icons
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = false, -- automatically close the list when you have no diagnostics
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
      signs = {
        -- icons / text used for a diagnostic
        error = status.diagnostic.error.icon,
        warning = status.diagnostic.warn.icon,
        hint = status.diagnostic.hint.icon,
        information = status.diagnostic.error.icon,
        other = ""
      },
      use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    }
  end
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

local incline_conf = {
  'b0o/incline.nvim',
  opts = {
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
}


local aerial_conf = {
  'stevearc/aerial.nvim',
  event = { "BufRead", "BufNewFile" },
  dependencies = { 'nvim-lspconfig' },
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
    end,
    layout = {
      min_width = 0.2,
    },
  }
}

local lines_conf = {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    vim.diagnostic.config({ virtual_lines = false })
    require("lsp_lines").setup()
  end,
}

local fidget_conf = {
  'j-hui/fidget.nvim',
  opts = {
      text = {
        done = "",
      },
  },
}

return {
  lsp_conf,
  lspkind_conf,
  lspsaga_conf,
  preview_conf,
  signature_conf,
  trouble_conf,
  incline_conf,
  aerial_conf,
  lines_conf,
  fidget_conf,
}
