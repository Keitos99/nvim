local M = {
  "williamboman/mason.nvim", -- Installer for LSP, DAP, Linter and Formatter
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- connects mason with lspconfig
  },
  event = "BufReadPost",
  cmd = "Mason",
}

M.config = function()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_install_dir = require("config.globals").mason.install_dir

  mason.setup({
    install_root_dir = mason_install_dir,
    ui = { border = "rounded" },
  })

  local mason_handler = require("config.lsp.mason")
  mason_handler.install_tools(mason_lspconfig)
  mason_handler.setup_lsp(mason_lspconfig)
end

return M
