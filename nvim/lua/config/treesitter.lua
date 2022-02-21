local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local ensure_installed = {"lua", "norg", "python", "vue", "typescript"}

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

table.insert(ensure_installed, 'norg')
table.insert(ensure_installed, 'norg_meta')
table.insert(ensure_installed, 'norg_table')


configs.setup {
  ensure_installed = ensure_installed,
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "md" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
