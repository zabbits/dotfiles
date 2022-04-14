local M = {}

function M.config()
  local present, session = pcall(require, 'auto-sessioin')
  if not present then
    return
  end

  vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
  session.setup({
    log_level = 'error',
    auto_session_suppress_dirs = {'~/'},
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
    auto_session_enabled = false,
    auto_save_enabled = false,
    auto_restore_enabled = false,
    auto_session_use_git_branch = nil,
    -- the configs below are lua only
    bypass_session_save_file_types = nil
  })
  
end

return M
