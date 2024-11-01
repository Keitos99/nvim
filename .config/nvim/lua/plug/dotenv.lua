return {
  "ellisonleao/dotenv.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    enable_on_load = true, -- will load your .env file upon loading a buffer
    verbose = false, -- show error notification if .env file is not found and if .env is loaded
  },

  config = function(_, opts)
    require("dotenv").setup(opts)

    -- Reload environment variables when .env file is saved
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = ".env",
      callback = function() require("dotenv").command() end,
    })
  end,
}
