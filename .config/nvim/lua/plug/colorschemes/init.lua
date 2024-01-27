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
local sonokai = require("plug.colorschemes.sonokai")

-- must be loaded before everything else
sonokai.lazy = false
sonokai.priority = 1000

local M = {
  sonokai,
  modus,
  kanagawa,
  rosepine,
}

return M
