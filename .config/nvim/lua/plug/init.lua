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
    cmd = {
      "CVSCompare",
      "CVSReplace",
      "CVSBlame",
      "CVSChose",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local Helper = require("config.helper")

      require("cvs").setup({
        find_root = Helper.find_root,
        is_available = function()
          local is_vpn_connected = vim.fn.system("ip route | grep -q 10.8.0.1; echo $?") ~= 1
          return is_vpn_connected
        end,
      })
    end,
  },
  -- {
  --   dir = vim.fn.expand("~") .. "/Documents/Workspace/Github/tohtml.nvim",
  --   cmd = "TSToHTML",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     filetype_to_parser_language = {
  --       ["4gl"] = "e4glide",
  --     },
  --   },
  -- },
}
