local kanagawa = require("plug.colorschemes.kanagawa")
local modus = require("plug.colorschemes.modus")
local sonokai = require("plug.colorschemes.sonokai")
local midnight = require("plug.colorschemes.midnight")
local catppuccin = require("plug.colorschemes.catppuccin")

-- must be loaded before everything else
kanagawa.lazy = false
kanagawa.priority = 1000

return {
  midnight,
  sonokai,
  modus,
  kanagawa,
  catppuccin,
}
