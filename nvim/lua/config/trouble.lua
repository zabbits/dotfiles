local ok, trouble = pcall(require, 'trouble')
if not ok then
  return
end

trouble.setup {
  position    = "bottom", -- position of the list can be: bottom, top, left, right
  height      = 7, -- height of the trouble list when position is top or bottom
  width       = 50, -- width of the list when position is left or right
  icons       = true, -- use devicons for filenames
  mode        = "workspace_diagnostics", -- lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open   = "", -- icon used for open folds
  fold_closed = "", -- icon used for closed folds
  indent_lines    = true, -- add an indent guide below the fold icons
  auto_open       = false, -- automatically open the list when you have diagnostics
  auto_close      = true, -- automatically close the list when you have no diagnostics
  auto_preview    = false, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold       = false, -- automatically fold a file trouble list at creation
  signs = {
    -- icons / text used for a diagnostic
    error       = "",
    warning     = "",
    hint        = "",
    information = "",
    other       = "﫠"
  },
  use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}