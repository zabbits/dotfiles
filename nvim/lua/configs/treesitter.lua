local M = {}

function M.config()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  -- add support for neorg
  local parser_configs = require "nvim-treesitter.parsers".get_parser_configs()
  -- These two are optional and provide syntax highlighting
  -- for Neorg tables and the @document.meta tag
  parser_configs.norg_meta = {
      install_info = {
          url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
          files = { "src/parser.c" },
          branch = "main"
      },
  }
  parser_configs.norg_table = {
      install_info = {
          url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
          files = { "src/parser.c" },
          branch = "main"
      },
  }

  local default_opts = {
    ensure_installed = {'lua', 'python', 'vue', 'typescript'},
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
    autopairs = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = false,
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
  }

  treesitter.setup(default_opts)
end

return M
