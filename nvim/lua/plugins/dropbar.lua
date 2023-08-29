return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    general = {
      ---@type boolean|fun(buf: integer, win: integer): boolean
      enable = function(buf, win)
        return vim.bo[buf].filetype ~= "" -- new check
          and not vim.api.nvim_win_get_config(win).zindex
          and vim.bo[buf].buftype == ""
          and vim.api.nvim_buf_get_name(buf) ~= ""
          and not vim.wo[win].diff
      end,
      attach_events = {
        "OptionSet",
        "BufWinEnter",
        "BufWritePost",
      },
    },
    icons = {
      ui = {
        bar = {
          separator = "  ",
          extends = "…",
        },
        menu = {
          separator = " ",
          indicator = "  ",
        },
      },
    },
  },
}
