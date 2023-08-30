Void = setmetatable({}, {
  __index = function(self)
    return self
  end,
  __newindex = function() end,
  __call = function() end,
})

local function prequire(module_name)
  local available, module = pcall(require, module_name)
  if available then
    return module, true
  else
    return Void, false
  end
end

return {
  "rebelot/heirline.nvim",
  event = { "BufAdd", "BufReadPre", "BufRead", "BufNewFile" },
  config = function()
    local os_sep = package.config:sub(1, 1)
    local api = vim.api
    local fn = vim.fn
    local bo = vim.bo

    local conditions = require("heirline.conditions")
    local heirline = require("heirline.utils")
    local devicons = prequire("nvim-web-devicons")
    local dap = prequire("dap")
    local util = require("plugins.heirline.util")
    local icons = util.icons
    local mode = util.mode

    local theme = require("plugins.heirline.themes")
    local hl = theme.highlight
    local colors = theme.colors
    local lsp_colors = theme.lsp_colors

    -- Flexible components priorities
    local priority = {
      ScrollPercentage = 70,
      CurrentPath = 60,
      Git = 40,
      WorkDir = 25,
      Lsp = 30,
    }

    local Align, Space, Null, ReadOnly
    do
      Null = { provider = "" }

      Align = { provider = "%=" }

      Space = setmetatable({ provider = " " }, {
        __call = function(_, n)
          return { provider = string.rep(" ", n) }
        end,
      })

      ReadOnly = {
        condition = function()
          return not bo.modifiable or bo.readonly
        end,
        provider = icons.padlock,
        hl = hl.ReadOnly,
      }
    end

    local LeftCap = {
      provider = "▌",
      hl = hl.Mode.normal,
    }

    local ViMode = {
      -- get vim current mode, this information will be required by the provider
      -- and the highlight functions, so we compute it only once per component
      -- evaluation and store it as a component attribute
      init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
      end,
      -- Now we define some dictionaries to map the output of mode() to the
      -- corresponding string and color. We can put these into `static` to compute
      -- them at initialisation time.
      static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
          n = "N",
          no = "N?",
          nov = "N?",
          noV = "N?",
          ["no\22"] = "N?",
          niI = "Ni",
          niR = "Nr",
          niV = "Nv",
          nt = "Nt",
          v = "V",
          vs = "Vs",
          V = "Vl",
          Vs = "Vs",
          ["\22"] = "^V",
          ["\22s"] = "^V",
          s = "S",
          S = "S_",
          ["\19"] = "^S",
          i = "I",
          ic = "Ic",
          ix = "Ix",
          R = "R",
          Rc = "Rc",
          Rx = "Rx",
          Rv = "Rv",
          Rvc = "Rv",
          Rvx = "Rv",
          c = "C",
          cv = "Ex",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "T",
        },
        mode_colors = {
          n = "red",
          i = "green",
          v = "cyan",
          V = "cyan",
          ["\22"] = "cyan",
          c = "orange",
          s = "purple",
          S = "purple",
          ["\19"] = "purple",
          R = "orange",
          r = "orange",
          ["!"] = "red",
          t = "red",
        },
      },
      -- We can now access the value of mode() that, by now, would have been
      -- computed by `init()` and use it to index our strings dictionary.
      -- note how `static` fields become just regular attributes once the
      -- component is instantiated.
      -- To be extra meticulous, we can also add some vim statusline syntax to
      -- control the padding and make sure our string is always at least 2
      -- characters long. Plus a nice Icon.
      provider = function(self)
        if self.mode == "n" then
          return ""
        end
        return " " .. self.mode_names[self.mode] .. ""
      end,
      -- Same goes for the highlight. Now the foreground will change according to the current mode.
      hl = function(self)
        local mode_ = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_colors[mode_], bold = true }
      end,
      -- Re-evaluate the component only on ModeChanged event!
      -- Also allows the statusline to be re-evaluated when entering operator-pending mode
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd("redrawstatus")
        end),
      },
    }

    local FileNameBlock, CurrentPath, FileName
    do
      local FileIcon = {
        condition = function()
          return not ReadOnly.condition()
        end,
        init = function(self)
          local filename = self.filename
          local extension = fn.fnamemodify(filename, ":e")
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
          if bo.buftype == "" then
            return self.pwd
          end
        end,
        hl = hl.WorkDir,
        flexible = priority.WorkDir,
        {
          provider = function(self)
            return self.pwd
          end,
        },
        {
          provider = function(self)
            return fn.pathshorten(self.pwd)
          end,
        },
        Null,
      }

      CurrentPath = {
        condition = function(self)
          if bo.buftype == "" then
            return self.current_path
          end
        end,
        hl = hl.CurrentPath,
        flexible = priority.CurrentPath,
        {
          provider = function(self)
            return self.current_path
          end,
        },
        {
          provider = function(self)
            return fn.pathshorten(self.current_path, 2)
          end,
        },
        { provider = "" },
      }

      FileName = {
        provider = function(self)
          return self.filename
        end,
        hl = hl.FileName,
      }

      FileNameBlock = {
        { FileIcon, WorkDir, CurrentPath, FileName },
        -- This means that the statusline is cut here when there's not enough space.
        { provider = "%<" },
      }
    end

    --------------------------------------------------------------------------------

    local FileProperties = {
      condition = function(self)
        self.filetype = bo.filetype

        local encoding = (bo.fileencoding ~= "" and bo.fileencoding) or vim.o.encoding
        self.encoding = encoding

        local fileformat = bo.fileformat

        if fileformat == "dos" then
          fileformat = ""
        elseif fileformat == "mac" then
          fileformat = ""
        else -- 'unix'
          fileformat = "󰣇"
        end

        self.fileformat = fileformat

        return self.fileformat or self.encoding
      end,
      provider = function(self)
        local sep = (self.fileformat and self.encoding) and " " or ""
        return table.concat({ " ", self.fileformat or "", sep, self.encoding or "" })
      end,
      hl = hl.FileProperties,
    }

    local DapMessages = {
      -- display the dap messages only on the debugged file
      condition = function()
        -- local session = dap_available and dap.session()
        local session = dap.session()
        if session then
          local filename = api.nvim_buf_get_name(0)
          if session.config then
            local progname = session.config.program
            return filename == progname
          end
        end
        return false
      end,
      provider = function()
        return " " .. dap.status() .. " "
      end,
      hl = hl.DapMessages,
    }

    local Diagnostics = {
      condition = conditions.has_diagnostics,
      static = {
        -- error_icon = '󰂭 ',
      },
      init = function(self)
        self.error_icon = fn.sign_getdefined("DiagnosticSignError")[1].text
        self.warn_icon = fn.sign_getdefined("DiagnosticSignWarn")[1].text
        self.info_icon = fn.sign_getdefined("DiagnosticSignInfo")[1].text
        self.hint_icon = fn.sign_getdefined("DiagnosticSignHint")[1].text
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
      {
        provider = function(self)
          -- 0 is just another output, we can decide to print it or not!
          if self.errors > 0 then
            return table.concat({ self.error_icon, self.errors, " " })
          end
        end,
        hl = hl.Diagnostic.error,
      },
      {
        provider = function(self)
          if self.warnings > 0 then
            return table.concat({ self.warn_icon, self.warnings, " " })
          end
        end,
        hl = hl.Diagnostic.warn,
      },
      {
        provider = function(self)
          if self.info > 0 then
            return table.concat({ self.info_icon, self.info, " " })
          end
        end,
        hl = hl.Diagnostic.info,
      },
      {
        provider = function(self)
          if self.hints > 0 then
            return table.concat({ self.hint_icon, self.hints, " " })
          end
        end,
        hl = hl.Diagnostic.hint,
      },
      -- Space(1),
    }

    local Git
    do
      local GitBranch = {
        condition = conditions.is_git_repo,
        init = function(self)
          self.git_status = vim.b.gitsigns_status_dict
        end,
        hl = hl.Git.branch,
        provider = function(self)
          return table.concat({ " ", self.git_status.head })
        end,
      }

      Git = { GitBranch, Space }
    end

    local Lsp
    do
      local LspIndicator = {
        provider = "",
        hl = hl.LspIndicator,
      }

      local LspServer = {
        Space,
        {
          provider = function(self)
            local names = self.lsp_names
            if #names == 1 then
              names = names[1]
            else
              -- names = table.concat(vim.tbl_flatten({ '[', names, ']' }), ' ')
              names = table.concat(names, ", ")
            end
            return names
          end,
        },
        hl = hl.LspServer,
      }

      Lsp = {
        condition = conditions.lsp_attached,
        init = function(self)
          local names = {}
          for _, server in pairs(vim.lsp.get_clients()) do
            if server.name ~= "null-ls" then
              table.insert(names, server.name)
            end
          end
          self.lsp_names = names
        end,
        hl = function(self)
          local color
          for _, name in ipairs(self.lsp_names) do
            if lsp_colors[name] then
              color = lsp_colors[name]
              break
            end
          end
          if color then
            return { fg = color, bold = true, force = true }
          else
            return hl.LspServer
          end
        end,
        LspIndicator,
        LspServer,
      }
    end

    local SearchResults = {
      condition = function(self)
        local lines = api.nvim_buf_line_count(0)
        if lines > 50000 then
          return
        end

        local query = fn.getreg("/")
        if query == "" then
          return
        end

        if query:find("@") then
          return
        end

        local search_count = fn.searchcount({ recompute = 1, maxcount = -1 })
        local active = false
        if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
          active = true
        end
        if not active then
          return
        end

        query = query:gsub([[^\V]], "")
        query = query:gsub([[\<]], ""):gsub([[\>]], "")

        self.query = query
        self.count = search_count
        return true
      end,
      {
        provider = function(self)
          return table.concat({
            -- ' ', self.query, ' ', self.count.current, '/', self.count.total, ' '
            " ",
            self.count.current,
            "/",
            self.count.total,
            " ",
          })
        end,
        hl = hl.SearchResults,
      },
      Space,
    }

    local Ruler = {
      -- :help 'statusline'
      -- ------------------
      -- %-2 : make item takes at least 2 cells and be left justified
      -- %l  : current line number
      -- %L  : number of lines in the buffer
      -- %c  : column number
      -- %V  : virtual column number as -{num}.  Not displayed if equal to '%c'.
      provider = " %9(%l:%L%)  %-3(%c%V%) ",
      hl = { bold = true },
    }

    local ScrollPercentage = {
      condition = function()
        return true
      end,
      -- %P  : percentage through file of displayed window
      provider = " %3(%P%) ",
      hl = hl.ScrollBar,
    }

    local MacroRec = {
      condition = function()
        return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
      end,
      provider = " ",
      hl = { fg = "orange", bold = true },
      heirline.surround({ "[", "]" }, nil, {
        provider = function()
          return vim.fn.reg_recording()
        end,
        hl = { fg = "green", bold = true },
      }),
      update = {
        "RecordingEnter",
        "RecordingLeave",
      },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = "green" },
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "orange" },
      },
    }

    --------------------------------------------------------------------------------
    local StatusLines = {
      init = function(self)
        local pwd = fn.getcwd(0) -- Present working directory.
        local current_path = api.nvim_buf_get_name(0)
        local filename

        if current_path == "" then
          pwd = fn.fnamemodify(pwd, ":~")
          current_path = nil
          filename = " [No Name]"
        elseif current_path:find(pwd, 1, true) then
          filename = fn.fnamemodify(current_path, ":t")
          current_path = fn.fnamemodify(current_path, ":~:.:h")
          pwd = fn.fnamemodify(pwd, ":~") .. os_sep
          if current_path == "." then
            current_path = nil
          else
            current_path = current_path .. os_sep
          end
        else
          pwd = nil
          filename = fn.fnamemodify(current_path, ":t")
          current_path = fn.fnamemodify(current_path, ":~:.:h") .. os_sep
        end

        self.pwd = pwd
        self.current_path = current_path -- The opened file path relevant to pwd.
        self.filename = filename
      end,
      hl = hl.StatusLine,
      {
        LeftCap,
        ViMode,
        Space,
        Git,
        Diagnostics,
        {
          fallthrough = false,
          { FileNameBlock, FileFlags },
        },
        Space(2),
        -- GPS,
        Align,
        DapMessages,
        MacroRec,
        Space(1),
        SearchResults,
        Lsp,
        FileProperties,
        -- Ruler, ScrollBar, ScrollPercentage
        -- Ruler,
        ScrollPercentage,
        LeftCap,
      },
    }

    --------------------------------------------------------------------------------

    vim.opt.showmode = false
    vim.opt.laststatus = 3
    require("heirline").setup({
      statusline = StatusLines,
      -- winbar = WinBars,
      -- tabline = ...,
      -- statuscolumn = ...
    })
  end,
}
