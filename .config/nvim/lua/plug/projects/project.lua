local M = {
  "ahmedkhalf/project.nvim",
  config = function()
    local project = require("project_nvim")

    project.setup({
      ---@usage set to false to disable project.nvim.
      --- This is on by default since it's currently the expected behavior.
      active = true,

      on_config_done = nil,

      ---@usage set to true to disable setting the current-woriking directory
      --- Manual mode doesn't automatically change your root directory, so you have
      --- the option to manually do so using `:ProjectRoot` command.
      manual_mode = false,

      -- NOTE: lsp detection will get annoying with multiple langs in one project
      -- but is most accurate (eg. single file typescript projects)
      detection_methods = { "lsp", "pattern" },

      ---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
      patterns = require("config.globals").root_patterns,

      ---@ Show hidden files in telescope when searching for files in a project
      show_hidden = true,

      ---@usage When set to false, you will get a message when project.nvim changes your directory.
      -- When set to false, you will get a message when project.nvim changes your directory.
      silent_chdir = true,

      ---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
      ignore_lsp = {},

      ---@type string
      ---@usage path to store the project history for use in telescope
      datapath = vim.fn.stdpath("data") .. "/project/",
    })
  end,
}

return M
