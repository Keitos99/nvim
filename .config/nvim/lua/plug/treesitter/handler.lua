local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("Could not load nvim-treesitter.configs")
  return
end

local M = {}

M.DEFAULT_CONFIG = {
  ensure_installed = require("config.globals").tree_sitter_parsers,
  sync_install = false,
  ignore_install = { "swift", "help" }, -- List of parsers to ignore installing
  auto_install = false,
}

local config = M.DEFAULT_CONFIG

local fold_file = function()
  -- enable folding
  vim.opt.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
end

M.reset = function()
  config = M.DEFAULT_CONFIG
end

M.disable_large = function(lang, buf)
  local max_filesize = 300 * 1024 -- 300 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    vim.notify_once("Disabled for " .. tostring(lang) .. ": " .. stats.size)
    return false
  end
end

M.setup = function(param)
  config = param or config
  configs.setup(config)
  vim.keymap.set("n", "<leader>tf", fold_file)
end

M.add_plugin = function(name, plugin_config)
  config[name] = plugin_config
end

M.start = function()
  M.setup(config)
end

M.print_config = function()
  print(vim.inspect(config))
end

return M
