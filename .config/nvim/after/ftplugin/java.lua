-- MUST be called from after/ftplugin/java.lua, because only then will jdtls attach to each java file
local jdtls = require("jdtls")
local was_successful, config = pcall(require, "config.helper.jdtls")

if not was_successful then
  -- print the error message
  print("Error loading jdtls config: ", config)
  return
end
jdtls.start_or_attach(config)
