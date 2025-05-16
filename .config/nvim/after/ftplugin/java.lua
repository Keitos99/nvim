-- MUST be called from after/ftplugin/java.lua, because only then will jdtls attach to each java file
local bufnr = vim.api.nvim_get_current_buf()
local jdtls = require("jdtls")
local was_successful, config = pcall(require, "config.helper.jdtls")

if not was_successful then
  -- print the error message
  print("Error loading jdtls config: ", config)
  return
end

jdtls.start_or_attach(config)

-- HACK: Temporary fix to ensure that the LSP client always attaches to the buffer
if vim.env.JDTLS_WAS_STARTED == "1" then return end

print("AGYP[928]: java.lua:15 (before vim.env.TEST = 1)")
vim.env.JDTLS_WAS_STARTED = "1"
vim.lsp.config("jdtls", config)
