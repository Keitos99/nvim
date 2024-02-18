return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opt = true,
  cmd = { "Refactor" },
  keys = {
    {
      "<leader>rr",
      function()
        require("refactoring").select_refactor({})
      end,
      mode = { "n", "x" },
    },

    {
      mode = "x",
      "<leader>re",
      function()
        require("refactoring").refactor("Extract Function")
      end,
    },

    {
      mode = "x",
      "<leader>rf",
      function()
        require("refactoring").refactor("Extract Function To File")
      end,
    },
    {
      -- Extract function supports only visual mode
      mode = "x",
      "<leader>rv",
      function()
        require("refactoring").refactor("Extract Variable")
      end,
    },
    {
      -- Extract variable supports only visual mode
      "<leader>rI",
      function()
        require("refactoring").refactor("Inline Function")
      end,
    },
    {
      -- Inline func supports only normal
      mode = { "n", "x" },
      "<leader>ri",
      function()
        require("refactoring").refactor("Inline Variable")
      end,
    },

    -- Inline var supports both normal and visual mode
    {
      "<leader>rb",
      function()
        require("refactoring").refactor("Extract Block")
      end,
    },
    {
      "n",
      "<leader>rbf",
      function()
        require("refactoring").refactor("Extract Block To File")
      end,
    },
  },
}
