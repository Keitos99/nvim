local M = {
  "anuvyklack/hydra.nvim",
  event = "VeryLazy",
}

function M.config()
  require("plug.hydra.windows")
end

return M
