local M = {}

function M.config()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end


  local ensure_installed = {
    'lua', 'python', 'vue',
    'typescript', 'norg',
    'html', 'css', 'go',
    'rust', 'c',
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
    autopairs = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { "yaml", "norg", "org", "rust", "python", "c", "lua", "json"},
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

  treesitter.setup(opts)
end

return M
