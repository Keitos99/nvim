local M = {
  -- Smart and Powerful commenting plugin for neovim
  "numToStr/Comment.nvim",
  event = "BufReadPost",
}

function M.config()
  local comment = require("Comment")
  comment.setup()
end

return M
