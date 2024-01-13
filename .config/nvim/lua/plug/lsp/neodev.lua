local M = {
  "folke/neodev.nvim",
  priority = 1000, -- must load before the configurations for the lua_ls-server
  lazy = false, -- TODO: must find another way
  ft = "lua",
  opts = true,
}

return M
