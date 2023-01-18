local M = {
  'anuvyklack/hydra.nvim',
  event = { 'BufNewFile', 'BufRead' },
}

local function cmd(command)
  return table.concat({ '<Cmd>', command, '<CR>' })
end

function M.config()
  local hydra = safe_require('hydra')
  local splits = require('smart-splits')
  if not hydra or not splits then
    return
  end

  local window_hint = [[
   ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
   ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
   ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
   _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
   ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _c_: close
   focus^^^^^^  window^^^^^^  ^_=_: equalize^   _o_: remain only
   ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   
  ]]

  hydra({
    name = 'Windows',
    hint = window_hint,
    config = {
      invoke_on_body = true,
      hint = {
        border = 'rounded',
        offset = -1
      }
    },
    mode = 'n',
    body = '<C-w>',
    heads = {
      { 'h', '<C-w>h' },
      { 'j', '<C-w>j' },
      { 'k', cmd [[try | wincmd k | catch /^Vim\%((\a\+)\)\=:E11:/ | close | endtry]] },
      { 'l', '<C-w>l' },

      { 'H', cmd 'WinShift left' },
      { 'J', cmd 'WinShift down' },
      { 'K', cmd 'WinShift up' },
      { 'L', cmd 'WinShift right' },

      { '<C-h>', function() splits.resize_left(2) end },
      { '<C-j>', function() splits.resize_down(2) end },
      { '<C-k>', function() splits.resize_up(2) end },
      { '<C-l>', function() splits.resize_right(2) end },
      { '=', '<C-w>=', { desc = 'equalize' } },

      { 's', '<C-w>s' }, { '<C-s>', '<C-w><C-s>', { desc = false } },
      { 'v', '<C-w>v' }, { '<C-v>', '<C-w><C-v>', { desc = false } },

      { 'w', '<C-w>w', { exit = true, desc = false } },
      { '<C-w>', '<C-w>w', { exit = true, desc = false } },

      { 'o', '<C-w>o', { exit = true, desc = 'remain only' } },
      { '<C-o>', '<C-w>o', { exit = true, desc = false } },


      { 'c', cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = 'close window' } },
      { '<C-q>', cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = false } },
      { '<C-c>', cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = false } },

      { 'q', nil, { exit = true, desc = false } },
      { '<Esc>', nil, { exit = true, desc = false } }
    }
  })

end

return M
