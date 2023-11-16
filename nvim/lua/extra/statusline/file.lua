local colors = require("extra.statusline.colors")
local hl = colors.highlight
local devicons = require("nvim-web-devicons")

local Null = { provider = "" }

local FileIcon = {
    condition = function(self)
        return not self.ReadOnly.condition()
    end,
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        if self.icon then
            return self.icon .. " "
        end
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end,
}

local WorkDir = {
    condition = function(self)
        if vim.bo.buftype == "" then
            return self.pwd
        end
    end,
    hl = hl.WorkDir,
    flexible = 25,
    {
        provider = function(self)
            return self.pwd
        end,
    },
    {
        provider = function(self)
            return vim.fn.pathshorten(self.pwd)
        end,
    },
    Null,
}

local CurrentPath = {
    condition = function(self)
        if vim.bo.buftype == "" then
            return self.current_path
        end
    end,
    hl = hl.CurrentPath,
    flexible = 60,
    {
        provider = function(self)
            return self.current_path
        end,
    },
    {
        provider = function(self)
            return vim.fn.pathshorten(self.current_path, 2)
        end,
    },
    { provider = "" },
}

local FileName = {
    provider = function(self)
        return self.filename
    end,
    hl = hl.FileName,
}

local FileNameBlock = {
    init = function(self)
        local os_sep = package.config:sub(1, 1)
        local pwd = vim.fn.getcwd(0) -- Present working directory.
        local current_path = vim.api.nvim_buf_get_name(0)
        local filename

        if current_path == "" then
            pwd = vim.fn.fnamemodify(pwd, ":~")
            ---@diagnostic disable-next-line
            current_path = nil
            filename = " [No Name]"
        elseif current_path:find(pwd, 1, true) then
            filename = vim.fn.fnamemodify(current_path, ":t")
            current_path = vim.fn.fnamemodify(current_path, ":~:.:h")
            pwd = vim.fn.fnamemodify(pwd, ":~") .. os_sep
            if current_path == "." then
                ---@diagnostic disable-next-line
                current_path = nil
            else
                current_path = current_path .. os_sep
            end
        else
            ---@diagnostic disable-next-line
            pwd = nil
            filename = vim.fn.fnamemodify(current_path, ":t")
            current_path = vim.fn.fnamemodify(current_path, ":~:.:h") .. os_sep
        end

        self.pwd = pwd
        self.current_path = current_path -- The opened file path relevant to pwd.
        self.filename = filename
    end,
    { FileIcon, WorkDir, CurrentPath, FileName },
    -- This means that the statusline is cut here when there's not enough space.
    { provider = "%<" },
}

return FileNameBlock
