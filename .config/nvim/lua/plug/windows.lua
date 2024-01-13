local M = {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    -- "anuvyklack/animation.nvim", -- FIX: disabled because of https://github.com/anuvyklack/windows.nvim/issues/27
  },
  event = "WinNew",
}

function M.config()
  vim.o.winwidth = 10
  vim.o.winminwidth = 10
  vim.o.equalalways = true

  local windows = require("windows")
  windows.setup({
    ignore = {
      buftype = { "quickfix", "nofile" },
      filetype = { --[[ "NvimTree", ]]
        "neo-tree",
        "undotree",
        "gundo",
        "netrw",
        -- "neotest-summary",
      },
    },
    autowidth = {
      enable = true,
    },
    animation = {
      -- FIX: disabled because of https://github.com/anuvyklack/windows.nvim/issues/27
      enable = false,
    },
  })
end

-- FIX:
-- completely deactivated, because when jumping into a file one left side, it tries to expand it, but does not completely
-- also cause issue with opening nvim-tree on the left side
return M
