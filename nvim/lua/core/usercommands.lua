vim.api.nvim_create_user_command("ToggleConcealLevel", function ()
  if vim.wo.conceallevel == 0 then
    vim.wo.conceallevel = 3
  else
    vim.wo.conceallevel = 0
  end
end, {})

