vim.loader.enable() -- new experimental lua-loader that byte-compiles and caches lua files.
require("config.options")
require("config.keymaps")
require("config.dotenv")
require("config.lazy") -- load my plugins
require("config.redir")
require("config.autocmds")
