function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  -- make background transparent
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local kanagawa = require("plug.colorschemes.kanagawa")
local rosepine = require("plug.colorschemes.rosepine")
local modus = require("plug.colorschemes.modus")

-- must be loaded before everything else
modus.lazy = false
modus.priority = 1000

local M = {
  modus,
  kanagawa,
  rosepine,
}

return M
