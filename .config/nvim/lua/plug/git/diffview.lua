return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "DiffviewToggle",
    "DiffviewOpen",
  },
  keys = {
    {
      "<leader>gdd",
      ":DiffviewToggle<CR>",
    },
    {
      "<leader>gdm",
      ":DiffviewOpen main..HEAD<CR>",
    },
  },

  config = function()
    vim.api.nvim_create_user_command("DiffviewToggle", function()
      local diffview = require("diffview")
      local open_view = require("diffview.lib").get_current_view()
      if open_view then
        diffview.close()
      else
        diffview.open({})
      end
    end, { nargs = "*", desc = "Toggle DiffView" })
    return true
  end,
}
