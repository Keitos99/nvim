local M = {
  "DrKJeff16/project.nvim",
  enabled = true,
  config = function()
    local project = require("project")

    project.setup({
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },
      patterns = require("config.globals").root_patterns,
      exclude_dirs = {},
      show_hidden = false,
      enable_autochdir = false,
      silent_chdir = false,
      scope_chdir = "global",
      different_owners = {
        allow = true,
      },
      lsp = {
        ignore = { "copilot", "harper_ls" },
        use_pattern_matching = true,
      },
      history = {
        size = 100,
      },
      telescope = {
        enabled = true,
        sort = "newest",
        prefer_file_browser = false,
      },
    })
  end,
}

return M
