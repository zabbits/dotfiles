local theme_conf = {
  'tiagovla/tokyodark.nvim',
  lazy = false,
  config = function()
    vim.cmd.colorscheme("tokyodark")
  end
}

local icons_conf = {
  "kyazdani42/nvim-web-devicons",
  config = { default = true },
}

local dressing_conf = {
  "stevearc/dressing.nvim",
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
}

local alpha_conf = {
  'goolord/alpha-nvim',
  event = "VimEnter",
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local header = {
      [[        ,--.      ,--.     ,--.  ,--.                ]],
      [[,--,--, `--' ,---.|  ,---. `--'  `--' ,---. ,--.,--. ]],
      [[|      \,--.| .--'|  .-.  |,--.  ,--.| .-. ||  ||  | ]],
      [[|  ||  ||  |\ `--.|  | |  ||  |  |  |' '-' ''  ''  ' ]],
      [[`--''--'`--' `---'`--' `--'`--'.-'  / `---'  `----'  ]],
      [[                               '---'                 ]],
    }

    dashboard.section.header.val = header

    dashboard.section.buttons.val = {
      dashboard.button('  e', 'ﱐ  New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('  f', '  Find files', ':lua require("telescope.builtin").find_files() <CR>'),
      dashboard.button('  o', '  Find old files', ':lua require("telescope.builtin").oldfiles() <CR>'),
      dashboard.button('  w', 'ﭨ  Live grep', ':lua require("telescope.builtin").live_grep() <CR>'),
      dashboard.button('  s', 'ﮫ  Sessions', ':lua require("telescope").extensions.possession.list() <CR>'),
      -- dashboard.button('  p', '  Find projects',
      --   ':lua require("telescope._extensions").manager.projects.projects() <CR>'),
      dashboard.button('  c', '  Configurations',
        ':lua require("telescope.builtin").find_files({cwd="$HOME/.config/nvim/"}) <CR>'),
      dashboard.button('  l', '  Lazy', ':Lazy <CR>'),
      dashboard.button('  q', '  Quit', ':qa <CR>')
    }

    -- Foot must be a table so that its height is correctly measured
    -- local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
    -- local num_plugins_tot = #vim.tbl_keys(packer_plugins)
    -- if num_plugins_tot <= 1 then
    --   dashboard.section.footer.val = { num_plugins_loaded .. ' / ' .. num_plugins_tot .. ' plugin ﮣ loaded' }
    -- else
    --   dashboard.section.footer.val = { num_plugins_loaded .. ' / ' .. num_plugins_tot .. ' plugins ﮣ loaded' }
    -- end
    dashboard.section.footer.opts.hl = 'Comment'

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    local head_butt_padding = 4
    local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
    local header_padding = math.max(0, math.ceil((vim.fn.winheight('$') - occu_height) * 0.25))
    local foot_butt_padding_ub = vim.o.lines - header_padding - occu_height - #dashboard.section.footer.val - 3
    local foot_butt_padding = math.floor((vim.fn.winheight('$') - 2 * header_padding - occu_height))
    foot_butt_padding = math.max(0,
      math.max(math.min(0, foot_butt_padding), math.min(math.max(0, foot_butt_padding), foot_butt_padding_ub)))

    dashboard.config.layout = {
      { type = 'padding', val = header_padding },
      dashboard.section.header,
      { type = 'padding', val = head_butt_padding },
      dashboard.section.buttons,
      { type = 'padding', val = foot_butt_padding },
      dashboard.section.footer
    }

    alpha.setup(dashboard.opts)
  end
}

-- Neovim UI Enhancer
local nui_conf = {
  "MunifTanjim/nui.nvim",
}

-- FIX: notify make first enter buffer issue
local notify_conf = {
  "rcarriga/nvim-notify",
  event = "BufWinEnter",
  -- enabled = false,
  config = function()
    local nf = require('notify')
    nf.setup({
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    })
    vim.notify = nf
  end
}


local feline_conf = {
  'feline-nvim/feline.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    local feline = require('feline')
    if not feline then
      return
    end
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
        {},
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
              -- bg = colors.blue,
              style = 'bold'
            },
          },
        },
        {},
      },
    }

    feline.setup({
      theme = {
        fg = "#A0A8CD",
        bg = "#11121D",
      },
      components = components,
      force_inactive = {
        filetypes = {
          "^NvimTree$", "^neo%-tree$", "^dashboard$",
          "^Outline$", "^aerial$", "^Trouble$", "^help$",
          "^harpoon$",
          "^TelescopePrompt$",
          "^neo%-tree%-popup$",
          "lazy",
        }
      },
      disable = {
        filetypes = {
        }
      }
    })
  end
}

local bufferline_conf = {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-web-devicons" },
  event = { 'BufRead', 'BufNewFile' },
  opts = {
    options = {
      offsets = {
        { filetype = "NvimTree", text = "", padding = 1 },
        { filetype = "neo-tree", text = "Neo-Tree", padding = 1 },
        { filetype = "Outline", text = "Outline", padding = 1 },
        { filetype = "Trouble", text = "Trouble", padding = 1 },
      },
      separator_style = { '^', '^' },
      buffer_close_icon = "",
      show_buffer_close_icons = false,
      modified_icon = "",
      close_icon = "",
      show_close_icon = true,
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_icons = true,
      always_show_bufferline = true,
      diagnostics = false,
    }
  },
}

local ccc_conf = {
  'uga-rosa/ccc.nvim',
  event = { "BufRead", "BufNewFile" },
  config = function()
    local ccc = require('ccc')
    if ccc then
      ccc.setup({})
      vim.cmd [["CccHighlighterEnable"]]
    end
  end
}

local indent_conf = {
  "echasnovski/mini.indentscope",
  event = "BufReadPre",
  opts = {
    symbol = "│",
    options = { try_as_border = true },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
    require("mini.indentscope").setup(opts)
  end,
}


return {
  theme_conf,
  icons_conf,
  alpha_conf,
  dressing_conf,
  notify_conf,
  feline_conf,
  bufferline_conf,
  ccc_conf,
  nui_conf,
  indent_conf,
}
