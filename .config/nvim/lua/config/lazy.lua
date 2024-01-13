local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_cache = vim.fn.stdpath("cache") .. "/lazy/cache"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end

-- prepand the lazy path to the runtimepath
vim.opt.runtimepath:prepend(lazy_path)

require("lazy").setup("plug", {
  defaults = { lazy = true },
  performance = {
    cache = {
      enabled = true,
      path = lazy_cache,
    },
  },
  checker = {
    enabled = true,
  },
})
