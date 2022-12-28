local M = {
  'michaelb/sniprun',
  dependencies = { 'neorg' },
  ft = { 'norg' },
  build = 'bash ./install.sh',
}

local function get_lang(start_line, pat_start)
  local start_pos = string.find(start_line, pat_start)
  local len = string.len(pat_start)
  return string.sub(start_line, start_pos + len):gsub("%s+", "")
end

local function run(pat_start, pat_end)
  local linenr_from = vim.fn.search(pat_start .. ".\\+$", "bnW")
  local linenr_until = vim.fn.search(pat_end .. ".*$", "nW")
  if linenr_from == 0 or linenr_until == 0 then
    vim.notify("Not inside a code block.")
    return
  end

  local start_line = vim.fn.getline(linenr_from)
  local lang_code = get_lang(start_line, pat_start)
  if lang_code == "" then
    print("Language is not defined.")
    return
  end

  local sa = require('sniprun.api')
  sa.run_range(linenr_from + 1, linenr_until - 1, lang_code)
end

function M.config()
  local snr = _G.safe_require('sniprun')
  if not snr then
    return
  end

  snr.setup({
    display = {
      "NvimNotify",
    },
    show_no_output = {
      "NvimNotify",
    }
  })

  _G.snr = {
    norg = function()
      run('@code', '@end')
    end
  }
end

return M
