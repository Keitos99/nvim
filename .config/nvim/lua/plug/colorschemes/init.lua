local kanagawa = require("plug.colorschemes.kanagawa")

-- must be loaded before everything else
kanagawa.lazy = false
kanagawa.priority = 1000

return {
  kanagawa,
}
