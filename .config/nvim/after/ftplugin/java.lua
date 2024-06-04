-- MUST be called from after/ftplugin/java.lua, because only then will jdtls attach to each java file
local jdtls = require("jdtls")
local config = require("config.lsp.settings.jdtls")
jdtls.start_or_attach(config)
