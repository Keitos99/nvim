local M = {
  "andrewferrier/debugprint.nvim",
  opts = {
    print_tag = "AGY",
    filetypes = {
      ["4gl"] = {
        left = 'call dbrte_log_message("',
        right = '")',
        mid_var = '" + (char)',
        right_var = ")",
      }
    },
  },
  keys = {
    "g?P",
    "g?p",
    "g?v",
    "g?V",
  },
  cmd = "DeleteDebugPrints",
}

return M
