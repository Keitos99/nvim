vim.loader.enable() -- new experimental lua-loader that byte-compiles and caches lua files.
require("config.options")
require("config.lazy") -- load my plugins
require("config.autocmds")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Load those files, after all plugins are initiated
    require("config.keymaps")
  end,
})
