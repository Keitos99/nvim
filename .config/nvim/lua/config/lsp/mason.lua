local M = {}
local mason_config = require("config.globals").mason

function M.install_tools(mason_lsp_config)
  local tools = mason_config.tools
  local lsps = mason_config.lsps

  -- auto-install formatters, lsps, etc.
  mason_lsp_config.setup({
    ensure_installed = lsps,
    automatic_installation = true,
  })

  -- auto-install not-lsp tools
  local mr = require("mason-registry")
  for _, tool in ipairs(tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then p:install() end
  end
end

function M.setup_lsp(mason_lsp_config)
  local lsp = require("plug.lsp.handlers")
  local lspconfig = require("lspconfig")

  -- Automatically setup lsp-servers installed with mason
  local default = vim.tbl_extend("force", lspconfig.util.default_config, {
    capabilities = lsp.capabilities,
  })

  -- this lsps will be setup manually or by a plugin
  local do_not_auto_setup = { "tsserver", "ts_ls", "rust_analyzer" }

  lspconfig.util.default_config = default
  for _, server_name in ipairs(mason_lsp_config.get_installed_servers()) do
    local can_be_setup = not vim.tbl_contains(do_not_auto_setup, server_name)
    if can_be_setup then
      local opts = {}
      local has_settings, server_opts = pcall(require, "config.lsp.settings." .. server_name)

      if has_settings then
        -- extend with lsp specified configuration
        opts = vim.tbl_extend("force", lspconfig.util.default_config, server_opts)
      end
      lspconfig[server_name].setup(opts)
    end
  end
end

return M
