-- ============ treesitter =============
local ts_conf = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { 'BufRead', 'BufNewFile' },
  dependencies = {
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    local ensure_installed = {
      'lua', 'python', 'vue',
      'typescript', 'norg',
      'html', 'css', 'go',
      'rust', 'c', 'vim',
      'regex', 'lua', 'bash',
      'markdown', 'markdown_inline',
    }

    local opts = {
      ensure_installed = ensure_installed,
      sync_install = false,
      ignore_install = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          scope_incremental = '<S-CR>',
          node_decremental = '<BS>',
        },
      },
      indent = {
        enable = true,
        disable = { "yaml", "norg", "org", "python", "c", "json", "go", "java" },
      },
      rainbow = {
        enable = true,
        disable = { "html" },
        extended_mode = false,
        max_file_lines = nil,
      },
      autotag = {
        enable = true,
      },
      textobjects = {
        lsp_interop = {
          enable = true,
          border = 'none',
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["al"] = "@loop.inner",
            ["il"] = "@loop.inner",
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = false,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
      },
    }

    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup(opts)
  end
}


-- ============ snip =============
local snip_conf = {
  'dcampos/nvim-snippy',
  event = "InsertEnter",
  dependencies = {
    'honza/vim-snippets',
  },
  opts = {
    mappings = {
      is = {
        ['<Tab>'] = 'expand_or_advance',
        ['<S-Tab>'] = 'previous',
      },
    },
  }
}

-- ============ cmp =============
local cmp_conf = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    'dcampos/cmp-snippy',
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp = require("cmp")
    local snippy = require("snippy")
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      formatting = {
        format = require('lspkind').cmp_format({
          mode = 'symbol_text',
          menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            snippy = "[Snippy]",
            luasnip = "[LuaSnip]",
            path = "[Path]",
            neorg = "[Neorg]",
            latex_symbols = "[LaTeX]",
            crates = "[Crates]",
          }),
        }),
      },
      snippet = {
        expand = function(args)
          snippy.expand_snippet(args.body)
        end,
      },
      duplicates = {
        nvim_lsp = 1,
        snippy = 1,
        luasnip = 1,
        cmp_tabnine = 1,
        buffer = 1,
        path = 1,
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
      },
      experimental = {
        ghost_text = false,
      },
      completion = {
        keyword_length = 1,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "snippy" },
        { name = "luasnip" },
        { name = "neorg" },
        { name = "buffer" },
        { name = "path" },
        { name = "crates" },
      },
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif snippy.can_jump(-1) then
            snippy.previous()
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })
  end
}

local pair_conf = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "nvim-cmp" },
  config = function()
    local npairs = require("nvim-autopairs")

    npairs.setup {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    }

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
  end
}

local comment_conf = {
  'echasnovski/mini.comment',
  -- lazy = false,
  keys = {
    { "gc", mode = { "n", "v" } },
    { "gb", mode = { "n", "v" } },
    { "<C-/>", mode = { "n", "v", "i" } },
  },
  config = function()
    require('mini.comment').setup({
      mappings = {
        comment = 'gc',
        comment_line = 'gcc',
        textobject = 'gc',
      },
      hooks = {
        pre_hook = require('ts_context_commentstring.internal').update_commentstring
      },
    })
  end,
}

local dap_conf = {
  'mfussenegger/nvim-dap',
  enabled = false,
  dependencies = {
    "mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected ', { text = '', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '.>', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped ', { text = '', texthl = '', linehl = '', numhl = '' })
    local dap = require("dap")
    local dapui = require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    dapui.setup({
      floating = { border = "rounded" }
    })
  end
}

local rust_conf = {
  'simrat39/rust-tools.nvim',
  ft = 'rust',
  dependencies = {
    'nvim-lspconfig',
    'plenary.nvim',
  },
  config = function()
    local rt = require("rust-tools")
    local handlers = require('plugins.lsp.handlers')

    local mason_path = vim.env.HOME .. '/.local/share/nvim/mason/packages'
    local codelldb_path = mason_path .. '/codelldb/extension/adapter/codelldb'

    local os = vim.loop.os_uname().sysname:lower()
    local postfix = '.so'
    if os == 'darwin' then
      postfix = 'dylib'
    end

    local liblldb_path = mason_path .. '/codelldb/extension/lldb/lib/liblldb' .. postfix

    rt.setup({
      hover_actions = {
        auto_focus = true,
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            inlayHints = { locationLinks = false },
          },
        },
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
      },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
          codelldb_path, liblldb_path)
      },
    })
  end
}

local crate_conf = {
  'saecki/crates.nvim',
  event = { "BufRead Cargo.toml" },
  config = function()
    local crates = require('crates')
    if crates then
      crates.setup()
    end
  end,
}

local neorg_conf = {
  "nvim-neorg/neorg",
  cmd = "Neorg",
  ft = 'norg',
  dependencies = { "nvim-treesitter" },
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.keybinds"] = {
        config = {
          default_keybinds = true,
          hook = function(keybinds)
            keybinds.remap("norg", "n", "<CR>", "<cmd>Neorg keybind norg core.norg.esupports.hop.hop-link<CR>")
          end,
        }
      },
      ["core.export"] = {},
      ["core.export.markdown"] = {},
      ["core.presenter"] = {
        config = {
          zen_mode = 'truezen',
        }
      },
      ["core.looking-glass"] = {},
      ["core.norg.journal"] = {
        config = {
          workspace = 'gtd',
        }
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work = '~/norg/work',
            home = '~/norg/home',
            note = '~/norg/note',
            gtd = '~/norg/gtd',
          }
        }
      },
      ["core.norg.manoeuvre"] = {},
      ["core.norg.concealer"] = {
        config = {
          -- icon_preset = 'varied',
          icons = {
            todo = {
              enabled = true,

              done = {
                enabled = true,
                icon = "",
                query = "(todo_item_done) @icon",
              },

              pending = {
                enabled = true,
                icon = "",
                query = "(todo_item_pending) @icon",
              },

              undone = {
                enabled = true,
                icon = "",
                query = "(todo_item_undone) @icon",
              },

              uncertain = {
                enabled = true,
                icon = "",
                query = "(todo_item_uncertain) @icon",
              },

              on_hold = {
                enabled = true,
                icon = "",
                query = "(todo_item_on_hold) @icon",
              },

              cancelled = {
                enabled = true,
                icon = "",
                query = "(todo_item_cancelled) @icon",
              },

              recurring = {
                enabled = true,
                icon = "↺",
                query = "(todo_item_recurring) @icon",
              },

              urgent = {
                enabled = true,
                icon = "⚠",
                query = "(todo_item_urgent) @icon",
              },
            },
            heading = {
              enabled = true,

              level_1 = {
                icon = "",
              },

              level_2 = {
                icon = " ✿",
              },

              level_3 = {
                icon = "  ",
              },

              level_4 = {
                icon = "   ○",
              },

              level_5 = {
                icon = "    ▶",
              },

              level_6 = {
                icon = "     ⤷",
              },
            },

            footnote = {
              single = {
                icon = "",
              },
              multi_prefix = {
                icon = " ",
              },
              multi_suffix = {
                icon = " ",
              },
            },
            delimiter = {
              weak = {
                icon = "⬸",
              },
              strong = {
                icon = "↢",
              },
            }

          }
        }
      },
      ["core.norg.qol.toc"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = 'nvim-cmp'
        }
      },
      ["core.integrations.nvim-cmp"] = {},
    }
  }
}


-- Get extra JSON schemas
local json_conf = {
  "b0o/SchemaStore.nvim",
  event = { "BufRead *.json" },
}

local surround_conf = {
  "tpope/vim-surround",
  event = { "BufRead", "BufNewFile" },
}

return {
  ts_conf,
  snip_conf,
  cmp_conf,
  pair_conf,
  comment_conf,
  dap_conf,
  rust_conf,
  crate_conf,
  neorg_conf,
  json_conf,
  surround_conf,
}
