local M = {
  "ahmedkhalf/project.nvim",
  config = function()
    local project = require("project_nvim")

    project.setup({
      logging = false,
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },

      patterns = require("config.globals").root_patterns,
      allow_patterns_for_lsp = true,
      allow_different_owners = true,
      enable_autochdir = false,
      historysize = 100,
      telescope = {
        enabled = true,
        sort = "newest",
        prefer_file_browser = false,
      },

      show_hidden = false,
      ignore_lsp = { "copilot", "harper_ls" },
      exclude_dirs = {},
      silent_chdir = false,
      scope_chdir = "global",
    })
  end,
}

return M
