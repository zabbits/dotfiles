-- 配置treesitter
local M = {}

local present, ts_config = pcall(require, "nvim-treesitter.configs")

-- nvim-treesitter-refactor: Highlight definitions, navigation and rename
local config_refactor = function()
  ts_config.setup {
    refactor = {
      highlight_definitions = { enable = false },
      highlight_current_scope = { enable = false },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr",
        },
      }
    }
  }
end


-- nvim-treesitter-textobjects: Textobjects defined by tree-sitter queries. 类似于vim原生的ip选择段落
local config_textobjects = function()
  ts_config.setup {
    textobjects = {
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
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      -- lsp 整合
      lsp_interop = {
        enable = true,
        border = 'none',
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
  }
end

-- p00f/nvim-ts-rainbow: Rainbow parentheses powered by tree-sitter
local config_rainbow = function()
   ts_config.setup {
     rainbow = {
       enable = true,
       extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
       max_file_lines = nil, -- Do not enable for files with more than n lines, int
       -- colors = {}, -- table of hex strings
       -- termcolors = {} -- table of colour name strings
     }
   }
end

-- windwp/nvim-ts-autotag: Auto-pairplugin 
local config_ts_autotag = function()
  ts_config.setup {
    autotag = {
      enable = true,
    }
  }
end


function M.setup()
	if not present then
	    return
	end
	ts_config.setup {
    ensure_installed = {
      "bash",
      "lua",
    },
    highlight = {
      enable = true,
      -- 不需要提示的语言
      disable = {},
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    -- treesitter的indent, 目前还是测试
    indent = {
      enable = false
    },
	}

  -- 额外的插件
  config_refactor()
  config_textobjects()
  config_rainbow()

end

return M
