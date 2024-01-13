local M = {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  dependencies = {
    {
      "nvim-treesitter/playground",
      cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" },
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "lukas-reineke/indent-blankline.nvim",
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

  treesitter.add_plugin("playground", {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  })

  treesitter.add_plugin("autotag", {
    enable = true,
    filetypes = { "html", "xml" },
  })

  treesitter.start()
end

return M
