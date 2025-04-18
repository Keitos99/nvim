return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    picker = { enabled = false }, -- I prefer to use telescope instead.
    indent = { enabled = false }, -- I prefer the style of indent-blankline.nvim over the snacks one.
    statuscolumn = { enabled = false }, -- I prefer to use the lualine instead.
    scope = { enabled = false },
    scroll = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    notifier = { enabled = false },
    words = { enabled = false },
  },
}
