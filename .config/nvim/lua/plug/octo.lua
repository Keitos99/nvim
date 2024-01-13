local M = {
  "pwntester/octo.nvim",
  -- event = "BufReadPre",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons" ,
  },
  opts = true,
}

M.cmd = {
  "Octo"
}
return M
