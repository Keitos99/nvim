local helper = require("config.helper.python")

return {
  on_init = function(client)
    -- HACK: set the pythonPath based of the project
    -- using infos from https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings#configure-in-your-personal-settings-initlua
    client.config.settings.python.pythonPath = helper.get_python_binary(vim.api.nvim_buf_get_name(0))
    venvPath = helper.get_project_root(vim.api.nvim_buf_get_name(0)):gsub("/bin/python$", "")
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    return true
  end,
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "workspace",
        typeCheckingMode = "basic", -- TODO: check if it should be true
        diagnosticSeverityOverrides = {
          reportUnusedImport = "warning",
          reportUnusedCallResult = false,
          reportMissingTypeStubs = false,
        },
      },

      exclude = { "build", "**/node_modules", "**/__pycache__", "src/experimental", "src/typestubs" },
    },
    python = {
      -- or add a pyrightconfig.json to the project that tells where the project venvs are
      -- NOTE: https://www.reddit.com/r/neovim/comments/18kyb5s/comment/kdvf597/?utm_source=share&utm_medium=web2x&context=3
      pythonPath = helper.get_project_root(vim.api.nvim_buf_get_name(0)),
    },
  },
}
