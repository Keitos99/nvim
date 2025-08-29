local M = {
  "mason-org/mason.nvim", -- Installer for LSP, DAP, Linter and Formatter
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  dependencies = {
    "mason-org/mason-lspconfig.nvim", -- connects mason with lspconfig
  },
  event = "BufReadPost",
  cmd = "Mason",
}

function installNonLSPTools(tools)
  local mr = require("mason-registry")
  for _, tool in ipairs(tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then p:install() end
  end
end

M.config = function()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_config = require("config.globals").mason

  local mason_install_dir = mason_config.install_dir
  local tools = mason_config.tools
  local lsps = mason_config.lsps

  mason.setup({
    install_root_dir = mason_install_dir,
    ui = { border = "rounded" },
  })

  -- auto-install not-lsp tools
  installNonLSPTools(tools)

  -- auto-install formatters, lsps, etc.
  mason_lspconfig.setup({
    ensure_installed = lsps,
    automatic_installation = true,
    automatic_enable = {
      exclude = {
        "tsserver",
        "ts_ls",
        "rust_analyzer",
      },
    },
  })

  vim.lsp.enable("jdtls")
end

return M
