vim.loader.enable() -- new experimental lua-loader that byte-compiles and caches lua files.
require("config.options")
require("config.lazy") -- load my plugins
require("config.autocmds")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Load those files, after all plugins are initiated
    require("config.keymaps")

    -- disable hlsearch automatically when your search is done. Enable it, when pressing one of the defined keys
    local ns = vim.api.nvim_create_namespace("toggle_hlsearch")

    local function toggle_hlsearch(char)
      if vim.fn.mode() ~= "n" then
        return
      end

      local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
      local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

      if vim.opt.hlsearch:get() ~= new_hlsearch then
        vim.opt.hlsearch = new_hlsearch
      end
    end

    vim.on_key(toggle_hlsearch, ns)
  end,
})
