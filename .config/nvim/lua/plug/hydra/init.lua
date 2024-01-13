local M = {
  "anuvyklack/hydra.nvim",
  lazy = false, -- must always be loaded
}

function M.config()
  require("plug.hydra.telescope")
  require("plug.hydra.windows")
  require("plug.hydra.options")
end

return M
