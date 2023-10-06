vim.z = {}
vim.z.map = function(mode, left, right, desc)
	local op = type(right) == "string" and "<CMD>" .. right .. "<CR>" or right
	vim.keymap.set(mode, left, op, { desc = desc, noremap = true, silent = true })
end

vim.z.mapo = function(mode, left, right, desc)
	vim.keymap.set(mode, left, right, { desc = desc, noremap = true, silent = true })
end
