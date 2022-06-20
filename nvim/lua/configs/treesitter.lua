local M = {}

function M.config()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end


  local ensure_installed = { 'lua', 'python', 'vue', 'typescript', 'norg', 'html', 'css', 'go', }

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
      disable = { "yaml" },
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
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
  }

  treesitter.setup(opts)

  -- from https://github.com/stevearc/dotfiles/blob/master/.config/nvim/after/plugin/treesitter.lua
  -- local disable_max_size = 2000000 -- 2MB
  -- local function should_disable(lang, bufnr)
  --   local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr or 0))
  --   -- size will be -2 if it doesn't fit into a number
  --   if size > disable_max_size or size == -2 then
  --     return true
  --   end
  --   return false
  -- end
  --
  -- local function set_ts_win_defaults()
  --   local parser_name = parsers.get_buf_lang()
  --   if parsers.has_parser(parser_name) and not should_disable(parser_name, 0) then
  --     local ok, has_folds = pcall(queries.get_query, parser_name, "folds")
  --     if ok and has_folds then
  --       if vim.wo.foldmethod == "manual" then
  --         vim.api.nvim_win_set_var(0, "ts_prev_foldmethod", vim.wo.foldmethod)
  --         vim.api.nvim_win_set_var(0, "ts_prev_foldexpr", vim.wo.foldexpr)
  --         vim.wo.foldmethod = "expr"
  --         vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
  --       end
  --       return
  --     end
  --   end
  --   if vim.wo.foldexpr == "nvim_treesitter#foldexpr()" then
  --     local ok, prev_foldmethod = pcall(vim.api.nvim_win_get_var, 0, "ts_prev_foldmethod")
  --     if ok and prev_foldmethod then
  --       vim.api.nvim_win_del_var(0, "ts_prev_foldmethod")
  --       vim.wo.foldmethod = prev_foldmethod
  --     end
  --     local ok2, prev_foldexpr = pcall(vim.api.nvim_win_get_var, 0, "ts_prev_foldexpr")
  --     if ok2 and prev_foldexpr then
  --       vim.api.nvim_win_del_var(0, "ts_prev_foldexpr")
  --       vim.wo.foldexpr = prev_foldexpr
  --     end
  --   end
  -- end
  --
  -- local aug = vim.api.nvim_create_augroup("TSConfig", {})
  -- vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  --   desc = "Set treesitter defaults on win enter",
  --   pattern = "*",
  --   callback = set_ts_win_defaults,
  --   group = aug,
  -- })
end

return M
