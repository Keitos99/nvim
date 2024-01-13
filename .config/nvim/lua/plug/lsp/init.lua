local M = {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "nvim-lua/plenary.nvim",    -- useful functions
      "ray-x/lsp_signature.nvim", -- show function signature when you type
    },
    config = function()
      local lsp = require("plug.lsp.handlers")
      lsp.setup()

      -- boarders of the floating windows should be rounded
      local lsp_config = { border = "rounded" }
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lsp_config)
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, lsp_config)

      local has_telescope, telescope = pcall(require, "telescope.builtin")
      if has_telescope then
        lsp.extend_with_telescope(telescope)
      end
    end,
  },
  require("plug.lsp.neodev"),
  require("plug.lsp.none-ls"), -- formatter and linter
  require("plug.lsp.mason"),
  require("plug.lsp.trouble"),
  require("plug.lsp.lines"),
  require("plug.lsp.fidget"),
  { "mfussenegger/nvim-jdtls", ft = "java", module = true },
  -- TODO:
  {
    "simaxme/java.nvim",
    ft = "java",
    config = function()
      require("java").setup {
        rename = {
          enable = true, -- enable the functionality for renaming java files
          nvimtree = true, -- enable nvimtree integration
          write_and_close = false -- automatically write and close modified (previously unopened) files after refactoring a java file
        },
        snippets = {
          enable = true -- enable the functionality for java snippets
        },
        root_markers = { -- markers for detecting the package path (the package path should start *after* the marker)
        "main/java/",
        "test/java/",
        "src"
      }
    }
    end
  },

  -- { "nanotee/sqls.nvim", ft = "sql", module = true },
}

return M
