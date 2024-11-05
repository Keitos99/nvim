return {
  "stevearc/overseer.nvim",
  lazy = false,
  opts = {
    task_list = {
      default_detail = 2,
      direction = "bottom",
      max_width = { 600, 0.7 },
      bindings = {
        ["<C-b>"] = "ScrollOutputUp",
        ["<C-f>"] = "ScrollOutputDown",
        -- Disable mappings I don't use.
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
        ["{"] = false,
        ["}"] = false,
      },
    },
  },
  config = function(_, opts) require("overseer").setup(opts) end,

  keys = {
    { "<leader>ot", "<cmd>lua require('overseer').toggle()<CR>" },
    { "<leader>oc", "<cmd>OverseerRun<CR>" },
  },
}
