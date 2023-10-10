vim.z = {}
vim.z.map = function(mode, left, right, desc, opts)
    opts = opts or { noremap = true, silent = true }
    opts.desc = desc
    local op = type(right) == "string" and "<CMD>" .. right .. "<CR>" or right
    vim.keymap.set(mode, left, op, opts)
end

vim.z.mapo = function(mode, left, right, desc, opts)
    opts = opts or { noremap = true, silent = true }
    opts.desc = desc
    vim.keymap.set(mode, left, right, opts)
end
