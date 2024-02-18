return {
  { "mfussenegger/nvim-dap-python", ft = "python", module = false },
  -- plugins that i wrote
  {
    dir = vim.fn.expand("~") .. "/Documents/Workspace/Github/tree-sitter-e4glide",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "4gl",
  },
  {
    dir = vim.fn.expand("~") .. "/Documents/Workspace/Github/cvs.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local Helper = require("config.helper")
      require("cvs").setup(Helper.find_root)
    end,
  },
  {
    dir = vim.fn.expand("~") .. "/Documents/Workspace/Github/tohtml.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("tohtml").setup({
        filetype_to_parser_language = {
          ["4gl"] = "e4glide",
        },
      })
    end,
  },
}
