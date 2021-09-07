-- 根据norg官方, 添加norg依赖, 由于暂时未由treesitter官方仓库维护, 需要手动添加
local ok, parser_config = pcall(require, 'nvim-treesitter.parsers')
if not ok then
    return
end
local ps_config = parser_config.get_parser_configs()
ps_config.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

-- 配置treesitter
local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end
ts_config.setup {
    ensure_installed = {
        "bash",
        "lua",
        "norg"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}

