return {
  { "mfussenegger/nvim-dap-python", ft = "python", module = false },
  -- plugins that i wrote
  {
    dir = vim.fn.expand("~") .. "/dev/personal/tree-sitter-e4glide",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "4gl",
    config = function()
      require("e4glide").setup()
      require("cmp").setup.filetype({ "4gl" }, {
        sources = {
          { name = "e4gl" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
  {
    dir = vim.fn.expand("~") .. "/dev/personal/cvs.nvim",
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
}
