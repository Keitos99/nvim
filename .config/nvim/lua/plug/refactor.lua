return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = true,
  cmd = { "Refactor" },
  keys = {
    {
      "<leader>rr",
      function() require("refactoring").select_refactor({ show_success_message = true }) end,
      mode = { "n", "x" },
      desc = "Select Refactor method",
    },

    {
      mode = "x",
      "<leader>re",
      function() require("refactoring").refactor("Extract Function") end,
      desc = "Refactor: Extract Function",
    },

    {
      mode = "x",
      "<leader>rf",
      function() require("refactoring").refactor("Extract Function To File") end,
      desc = "Refactor: Extract Funtion to File",
    },
    {
      -- Extract function supports only visual mode
      mode = "x",
      "<leader>rv",
      function() require("refactoring").refactor("Extract Variable") end,
      desc = "Refactor: Extract Variable",
    },
    {
      -- Extract variable supports only visual mode
      "<leader>rI",
      function() require("refactoring").refactor("Inline Function") end,
      desc = "Refactor: Inline Function",
    },
    {
      -- Inline func supports only normal
      mode = { "n", "x" },
      "<leader>ri",
      function() require("refactoring").refactor("Inline Variable") end,
      desc = "Refactor: Inline Variable",
    },

    -- Inline var supports both normal and visual mode
    {
      "<leader>rb",
      function() require("refactoring").refactor("Extract Block") end,
      desc = "Refactor: Extract Block",
    },
    {
      "<leader>rbf",
      function() require("refactoring").refactor("Extract Block To File") end,
      desc = "Refactor: Extract Block to File",
    },
  },
}
