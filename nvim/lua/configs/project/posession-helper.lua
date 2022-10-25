local M = {}

local session = require('possession.session')
local display = require('possession.display')
local utils = require('possession.utils')
local paths = require('possession.paths')

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local previewers = require('telescope.previewers')

-- posess on list
local session_list = function()
  local sessions = {}
  for file, data in pairs(session.list()) do
    data.file = file
    table.insert(sessions, data)
  end
  table.sort(sessions, function(a, b)
    return a.name < b.name
  end)
  return sessions
end

local function session_previewer(opts)
  return previewers.new_buffer_previewer {
    title = 'Session Preview',
    get_buffer_by_name = function(_, entry)
      return entry.value.name
    end,
    define_preview = function(self, entry, status)
      if self.state.bufname ~= entry.value.name then
        display.in_buffer(entry.value, self.state.bufnr)
      end
    end,
  }
end

local function last_session_name()
  local path = session.last()
  if not path then
    return ''
  end
  return paths.session_name(path)
end

-- our picker function: colors
function M.save_session(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Save Session",
    finder = finders.new_table {
      results = session_list(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    },
    previewer = session_previewer(opts),
    sorter = conf.generic_sorter(opts),
    default_text = last_session_name(),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local mode = vim.api.nvim_get_mode().mode
        local save_name;
        if (mode == "i") then
          save_name = action_state.get_current_line()
          -- use input to session name
        elseif mode == 'n' then
          save_name = action_state.get_selected_entry().value.name
        end
        if not save_name or save_name == '' then
          vim.notify("No session input or select!\nNotice: When normal mode, use select name. Otherwise, use input name")
          return
        end
        session.save(save_name, { no_confirm = true })
      end)
      return true
    end,
  }):find()
end

return M
