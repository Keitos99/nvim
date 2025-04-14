return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = true,
    ft = { "typescript", "javascript" },
  },

  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "javascript" },
    config = function() require("ts-error-translator").setup() end,
  },
}
