local M = {}

function M.setup()
	local tree_ok, tree = pcall(require, "nvim-tree")
	if tree_ok then
    tree.setup{}
	end
end


return M
