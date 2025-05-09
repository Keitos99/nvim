local user_cmds = vim.api.nvim_create_user_command

user_cmds("InlayToggle", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ method = "textDocument/inlayHint", bufnr = bufnr })
  if #clients == 0 then return end

  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end, {
  desc = "Toggle the LSP Inlay Hints",
})
