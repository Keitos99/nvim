return {
  -- plugins that i wrote
  {
    dir = vim.fn.expand("~") .. "/dev/personal/nvim-e4glide",
    lazy = false,
    dependencies = {
      { dir = vim.fn.expand("~") .. "/dev/personal/tree-sitter-e4glide" },
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-web-devicons").setup()
      require("e4glide").setup()
    end,
  },
}
