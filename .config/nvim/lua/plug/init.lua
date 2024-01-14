return {
  { "mfussenegger/nvim-dap-python", ft = "python", module = false },
  -- NOTE: Look into it when i have time
  -- https://code.visualstudio.com/docs/devcontainers/create-dev-container
  -- { "jamestthompson3/nvim-remote-containers" }, -- for deveoloping in docker containers
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
}
