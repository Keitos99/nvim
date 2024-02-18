local M = {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
}
function M.config()
  local treesitter = require("plug.treesitter.handler")

  treesitter.reset()
  treesitter.add_plugin("highlight", {
    enable = true, -- false will disable the whole extension
    disable = treesitter.disable_large, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  })

  treesitter.add_plugin("autotag", {
    enable = true,
    filetypes = { "html", "xml" },
  })

  treesitter.add_plugin("textobjects", {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<A-l>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<A-h>"] = "@parameter.inner",
      },
    },
  })

  treesitter.start()
end

return M
