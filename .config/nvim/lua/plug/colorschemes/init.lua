local kanagawa = require("plug.colorschemes.kanagawa")
local rosepine = require("plug.colorschemes.rosepine")
local modus = require("plug.colorschemes.modus")
local sonokai = require("plug.colorschemes.sonokai")
local midnight = require("plug.colorschemes.midnight")

-- must be loaded before everything else
sonokai.lazy = false
sonokai.priority = 1000

return {
  midnight,
  sonokai,
  modus,
  kanagawa,
  rosepine,
}
