local web_filetypes = {
  "html",
  "svelte",
  "css",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "vue",
  "php",
  "astro",
}

return {
  {
    -- tailwind-tools.lua
    "luckasRanarison/tailwind-tools.nvim",
    ft = web_filetypes,
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {}, -- your configuration
  },
  {
    "windwp/nvim-ts-autotag",
    ft = web_filetypes,
    opts = {},
  },
}
