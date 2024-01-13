local M = {
  "nvimtools/none-ls.nvim",
  event = "LspAttach",
}

M.config = function()
  local null_ls = require("null-ls")

  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  -- local diagnostics = null_ls.builtins.diagnostics -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

  -- TODO: add for other mason categories like linters
  local add_formatter = function(sources, package)
    local MasonPkg = require("mason-core.package")
    if not require("config.helper").has_value(package.spec.categories, MasonPkg.Cat.Formatter) then
      return sources
    end

    local null_ls_name = package.name:gsub("-", "_") -- NOTE: this seems to work(2022-10-29), but may cause problems in the future
    local is_null_ls_package, _ = pcall(require, "null-ls.builtins.formatting." .. null_ls_name)

    if is_null_ls_package then
      -- run formatting with configuration
      -- maybe the same way as for the lsp servers
      table.insert(sources, formatting[null_ls_name])
      return sources
    end

    vim.notify(
      'Could not find a null_ls equivalent for the mason package "' .. package.name .. '"!',
      vim.log.levels.ERROR
    )
    return sources
  end

  local get_sources = function()
    local sources = {}
    local registry = require("mason-registry")

    for _, package in ipairs(registry.get_installed_packages()) do
      sources = add_formatter(sources, package)
    end

    return sources
  end

  null_ls.setup({
    debug = false,
    sources = get_sources(),
  })
end

return M
