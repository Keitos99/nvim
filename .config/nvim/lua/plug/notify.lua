local M = {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
}

function M.config()
  local has_notify, notification = pcall(require, "notify")

  if not has_notify then
    return
  end

  require("notify").setup({
    background_colour = "#000000",
  })

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.notify = function(msg, ...)
    -- TODO: suppressing clangd error. SHOULD be handled differently
    -- according to https://www.reddit.com/r/neovim/comments/wmj8kb/i_have_nullls_and_clangd_attached_to_a_buffer_c/
    -- the following should fix this, but does not:
    -- capabilities.offsetEncoding = 'utf-8'
    if msg:match("warning: multiple different client offset_encodings") then
      return
    end

    notification(msg, ...)
  end
end

return M
