return {
  {
    "folke/neoconf.nvim",
    lazy = false,
    opt = true,
    priority = 1000, -- must be loaded before the lsp servers
  },
  { "mfussenegger/nvim-dap-python", ft = "python", module = false },
  -- plugins that i wrote
  {
    dir = vim.fn.expand("~") .. "/dev/personal/nvim-e4glide",
    dependencies = {
      { dir = vim.fn.expand("~") .. "/dev/personal/tree-sitter-e4glide" },
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "hrsh7th/nvim-cmp",
    },
    ft = "4gl",
    init = function()
      local client = vim.lsp.start_client({
        name = "lsp-e4glide",
        cmd = {
          vim.fn.expand("$HOME") .. "/.config/nvm/versions/node/v20.0.0/bin/node",
          vim.fn.expand("$HOME") .. "/dev/personal/lsp-e4glide/dist/index.js",
          "--stdio",
        },
        settings = {
          e4gl = {
            diagnostic = false,
          },
        },
      })

      if not client then
        vim.notify("Client could not be started")
        return
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "4gl",
        callback = function()
          vim.notify("Attaching lsp-e4glide client")
          vim.lsp.buf_attach_client(0, client)
        end,
      })
    end,
    config = function()
      require("nvim-web-devicons").setup()
      require("e4glide").setup()
      require("cmp").setup.filetype({ "4gl" }, {
        sources = {
          { name = "nvim_lsp" },
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
