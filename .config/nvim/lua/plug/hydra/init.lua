local M = {
  "anuvyklack/hydra.nvim",
  lazy = false, -- must always be loaded
}

function M.config()
  require("plug.hydra.windows")
end

return M
