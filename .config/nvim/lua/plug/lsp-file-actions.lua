return {
  {
    "antosha417/nvim-lsp-file-operations",
    lazy = false, -- TODO: lazy load this plugin
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function() require("lsp-file-operations").setup() end,
  },
}
