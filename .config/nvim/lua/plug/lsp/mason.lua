local M = {
  "williamboman/mason.nvim", -- Installer for LSP, DAP, Linter and Formatter
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- connects mason with lspconfig
  },
  event = "BufReadPost",
}

local mason_config = require("config.globals").mason
M.config = function()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup({
    install_root_dir = mason_config.install_dir,
    ui = { border = "rounded" },
  })
  M.install_tools(mason_lspconfig)
  M.setup_lsps(mason_lspconfig)
end

M.install_tools = function(mason_lspconfig)
  -- auto install used mason binaries
  local tools = mason_config.tools
  local lsps = mason_config.lsps

  -- auto-install formatters, lsps, etc.
  mason_lspconfig.setup({
    ensure_installed = lsps,
    automatic_installation = true,
  })

  -- auto-install not-lsp tools
  local mr = require("mason-registry")
  for _, tool in ipairs(tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

M.setup_lsps = function(mason_lspconfig)
  local lsp = require("plug.lsp.handlers")
  local lspconfig = require("lspconfig")

  -- Automatically setup lsp-servers installed with mason
  local default = vim.tbl_extend("force", lspconfig.util.default_config, {
    on_attach = lsp.on_attach,
    capabilities = lsp.capabilities,
  })

  lspconfig.util.default_config = default
  for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
    -- HACK: workaround, because still save lua-language-server as sumneko_lua and lspconfig only knows lua_ls
    local opts = {}
    local has_settings, server_opts = pcall(require, "plug.lsp.settings." .. server_name)

    if has_settings then
      -- extend with lsp specified configuration
      opts = vim.tbl_extend("force", lspconfig.util.default_config, server_opts)
    end
    lspconfig[server_name].setup(opts)
  end
end

return M
