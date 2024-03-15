local helper = require("config.helper.python")

return {
  on_init = function(client)
    -- HACK: redfining pythonPath, so that even on a project change it will use the correct one
    -- using infos from https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings#configure-in-your-personal-settings-initlua
    client.config.settings.python.pythonPath = helper.get_python_path(vim.api.nvim_buf_get_name(0))
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    return true
  end,
  on_attach = function(client, bufnr)
    require("plug.lsp.handlers").on_attach(client, bufnr)

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<A-o>", "<Cmd>PyrightOrganizeImports<CR>", opts)
  end,
  settings = {

    python = {
      analysis = {
        typeCheckingMode = "off", -- TODO: check if it should be true
        diagnosticSeverityOverrides = {
          reportUnusedImport = "warning",
        },
      },

      -- or add a pyrightconfig.json to the project that tells where the project venvs are
      -- NOTE: https://www.reddit.com/r/neovim/comments/18kyb5s/comment/kdvf597/?utm_source=share&utm_medium=web2x&context=3
      pythonPath = helper.get_python_path(vim.api.nvim_buf_get_name(0))
    },
  },
}
