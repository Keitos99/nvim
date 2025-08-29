local M = {
  "andrewferrier/debugprint.nvim",
  opts = {
    print_tag = "AGYP",
    filetypes = {
      ["4gl"] = {
        left = 'call dbrte_log_message("',
        right = '")',
        mid_var = '" + (char)(',
        right_var = "))",
      },
      ["e4glide"] = {
        left = 'call dbrte_log_message("',
        right = '")',
        mid_var = '" + (char)(',
        right_var = "))",
      },
    },
  },
  keys = {
    "g?p",
    "g?P",
    "g?v",
    "g?V",
    "g?sp",
    "g?sv",
    { "g?v", mode = "v" },
    { "g?V", mode = "v" },
  },
}

return M
