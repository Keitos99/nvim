local M = {
  "andrewferrier/debugprint.nvim",
  lazy = false,
  opts = {
    print_tag = "AGY",
    filetypes = {
      ["4gl"] = {
        left = 'call dbrte_log_message("',
        right = '")',
        mid_var = '" + (char)',
        right_var = ")",
      },
      ["e4glide"] = {
        left = 'call dbrte_log_message("',
        right = '")',
        mid_var = '" + (char)',
        right_var = ")",
      },
    },
  },
}

return M
