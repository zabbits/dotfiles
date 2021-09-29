local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- 移除space移动光标
map("n", "<Space>", "<NOP>", opt)

-- nvimtree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh<CR>", opt)


-- compe stuff
-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- 
-- local check_back_space = function()
--     local col = vim.fn.col(".") - 1
--     if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
--         return true
--     else
--         return false
--     end
-- end
-- 
-- _G.tab_complete = function()
--     if vim.fn.pumvisible() == 1 then
--         return t "<C-n>"
--     elseif check_back_space() then
--         return t "<Tab>"
--     else
--         return vim.fn["compe#complete"]()
--     end
-- end
-- 
-- _G.s_tab_complete = function()
    -- if vim.fn.pumvisible() == 1 then
--         return t "<C-p>"
--     elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--         return t "<Plug>(vsnip-jump-prev)"
--     else
--         return t "<S-Tab>"
--     end
-- end
-- 
-- function _G.completions()
--     local npairs
--     if
--         not pcall(
--             function()
--                 npairs = require "nvim-autopairs"
--             end
--         )
--      then
--         return
--     end
-- 
--     if vim.fn.pumvisible() == 1 then
--         if vim.fn.complete_info()["selected"] ~= -1 then
--             return vim.fn["compe#confirm"]("<CR>")
--         end
--     end
--     return npairs.check_break_line_char()
-- end
-- 
-- --  compe 补全
-- map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- map("i", "<CR>", "v:lua.completions()", {expr = true})

-- comment 注释
map("n", "<leader>/", ":CommentToggle<CR>", opt)
map("v", "<leader>/", ":CommentToggle<CR>", opt)

