local M = {
  "mrjones2014/smart-splits.nvim",
  event = { 'WinNew', 'TabNew' },
}

function M.config()
  local present, smart_splits = pcall(require, "smart-splits")
  if not present then
    return
  end

  smart_splits.setup({
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = {
      "nofile",
      "quickfix",
      "qf",
      "prompt",
      "neorg",
      "norg",
    },
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = { "nofile" },
    -- when moving cursor between splits left or right,
    -- place the cursor on the same row of the *screen*
    -- regardless of line numbers.
    -- Can be overridden via function parameter, see Usage.
    move_cursor_same_row = false,
  })
end

return M
