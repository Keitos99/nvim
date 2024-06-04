-- MUST be called from after/ftplugin/java.lua, because it has to called for each java file
-- or the lsp will not be attached
local jdtls = require("jdtls")
local config = require("config.lsp.settings.jdtls")
jdtls.start_or_attach(config)
